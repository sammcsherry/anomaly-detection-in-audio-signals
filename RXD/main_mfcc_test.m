%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;
set(gcf,'WindowStyle','docked');
% Define frame size and overlap in samples
frameDuration = 251e-3;

[audioData,sampleRate, frameLength] = extract_audio_data('jar.mp3', frameDuration);

frameOverlapPercentage = 0.6;
frameOverlapLength = frameOverlapPercentageframeLength;
frameOverlapDuration = frameOverlapLength/sampleRate;

[coeffs, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
anomalyVector = RXDWrapperFunc(coeffs);

numberOfFrames = size(coeffs,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

plotAnomalyScores(timeArray, anomalyVector, coeffs)

%plot thresholded data 
thresholdeData = get_threshold(anomalyVector, timeArray);