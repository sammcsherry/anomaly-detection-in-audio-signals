%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USER DEFINED INPUTS:
audiofile = 'jar.mp3';          %add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 250e-3;         %in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[audioData,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);

[coeffs, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
anomalyVector = RXDWrapperFunc(coeffs);

numberOfFrames = size(coeffs,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

plotAnomalyScores(timeArray, anomalyVector, coeffs)

%plot thresholded data 
[thresholdedData,s] = get_threshold(anomalyVector, timeArray);

%remove noise from detected anomalies
cleanedAnomalies = cleanAnomalies(thresholdedData, timeArray,s);