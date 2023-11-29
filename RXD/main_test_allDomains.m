%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER DEFINED INPUTS:
audiofile = 'AudioFiles/jar.mp3';          %add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-3;         %in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[audioData,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);


% overlapped fft NOT WORKING YET ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%windowFunction = hamming(frameLength); % Hamming window
%bufferedSignal = buffer(audioData, frameLength); %, frameOverlapLength, 'nodelay');
%windowedFrames = bsxfun(@times, bufferedSignal, windowFunction);

%coeffsFFT = fft(windowedFrames, [], 1); %overlapped fft that does not work
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

r = rem(length(audioData), frameLength);
audioData = audioData(1:end-r,:);
numCols = length(audioData)/frameLength;
audioData_forFFT = reshape(audioData, [frameLength, numCols]);
coeffsFFT = fft(audioData_forFFT); %NOT overlapped fft
coeffsFFT = coeffsFFT.';
coeffsFFT = abs(coeffsFFT).^2; % removing complex values
%coeffsFFT(end, :) = [];
%coeffsFFT = double(coeffsFFT.^2);
%isa(coeffsFFT,'double')
%coeffs = real(coeffsFFT);


%mel Spectorgram
[coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.

%mfcc
[coeffsMFCC, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);

anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);

numberOfFrames = size(coeffsMFCC,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);
timeArrayFFT = 0:25e-3:(numCols-1)*25e-3;

plotAnomalyScores(timeArrayFFT, anomalyVectorFFT, coeffsFFT)
plotAnomalyScores(timeArray, anomalyVectorMEL, coeffsMEL)
plotAnomalyScores(timeArray, anomalyVectorMFCC, coeffsMFCC)
%plot thresholded data 
%[thresholdedDataFFT,sFFT] = get_threshold(anomalyVectorFFT, timeArrayFFT);
[thresholdedDataMEL,sMEL] = get_threshold(anomalyVectorMEL, timeArray);
[thresholdedDataMFCC,sMFCC] = get_threshold(anomalyVectorMFCC, timeArray);

%remove noise from detected anomalies
N = 10; %left and right cells to average
%cleanedAnomaliesFFT = cleanAnomalies(thresholdedDataFFT, timeArray,sFFT, N);
cleanedAnomaliesMEL = cleanAnomalies(thresholdedDataMEL, timeArray,sMEL, N);
cleanedAnomaliesMFCC = cleanAnomalies(thresholdedDataMFCC, timeArray,sMEL, N);