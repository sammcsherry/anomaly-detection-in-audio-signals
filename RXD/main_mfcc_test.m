%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USER DEFINED INPUTS:
audiofile = 'AudioFiles/jar.mp3';          %add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-3;         %in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[audioData,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);

windowFunction = hamming(frameLength); % Hamming window
bufferedSignal = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
windowedFrames = bsxfun(@times, bufferedSignal, windowFunction);

%fft NOT WORKING YET
%{
coeffs = fft(windowedFrames, [], 1);
coeffs = coeffs.';
coeffs(end, :) = [];
coeffs = double(coeffs.^2);
%isa(coeffs,'double')
%coeffs = real(coeffs);
%}

%{
Following comment is to converge the domains.
fft = [];
mfcc = [];
mel = [];
result = convn(fft, mfcc, 'full');
allDomains = convn(result, mel, 'full'); 
%}

%mel Spectorgram
%[coeffs, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
%coeffs = coeffs'; % melSpectrogram does coloums as frames so must be transposed.

%mfcc
[coeffs, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
anomalyVector = calculateMahalanobis(coeffs);
numberOfFrames = size(coeffs,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

plotAnomalyScores(timeArray, anomalyVector, coeffs)

%plot thresholded data 
[thresholdedData,s] = get_threshold(anomalyVector, timeArray);

%remove noise from detected anomalies
N = 10; %left and right cells to average
cleanedAnomalies = cleanAnomalies(thresholdedData, timeArray,s, N);