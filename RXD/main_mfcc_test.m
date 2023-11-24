%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USER DEFINED INPUTS:
audiofile = 'jar.mp3';          %add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 250e-3;
% vectorLength = 500; 

%Note: is is better to define a frame by feature vector length or frame
%duration? i think length as this allows us to compare this to quantum more
%easily but I am unsure - help.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[audioData,sampleRate, frameLength] = extract_audio_data(audiofile, frameDuration);

frameOverlapLength = round(frameOverlapPercentage*frameLength);
frameOverlapDuration = frameOverlapLength/sampleRate;

[coeffs, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
anomalyVector = RXDWrapperFunc(coeffs);

numberOfFrames = size(coeffs,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

plotAnomalyScores(timeArray, anomalyVector, coeffs)

%plot thresholded data 
thresholdeData = get_threshold(anomalyVector, timeArray);