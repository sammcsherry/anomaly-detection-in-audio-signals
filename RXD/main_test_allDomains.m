%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER DEFINED INPUTS:
audiofile = 'AudioFiles/random.mp3';%add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-3;         %in seconds
largerFramDuration = 250e-3; % just testing tee hee
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);
segments = splitAudioData(audioData, sampleRate, 60);
numberOfSegments = size(segments,2);

%remove silence at start of audio file:
[audioData, startingDataPoint] = removeSilence(audioData);

[tempFFT] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate, "FFT");
[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "MFCC");
[tempMel] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "MEL");
[results] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "ALL");

numberOfFrames = size(tempFFT,2); 

%is adjustment needed on the time array?
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration, startingDataPoint);

%plot cleaned anomaly scores:
finalAnomalies1 = cleanRXDwrapperFunc(tempFFT, .9, 10);
finalAnomalies2 = cleanRXDwrapperFunc(tempMel, .9, 10);
finalAnomalies3 = cleanRXDwrapperFunc(tempMFCC, .9, 10);
plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Clean Anomalies vs Time";
tiledPlot(timeArray, plotTitles, figTitle, finalAnomalies1, finalAnomalies2, finalAnomalies3)

%plotting:
%{
plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Anomalies vs Time";
tiledPlot(timeArray, plotTitles, figTitle, tempFFT, tempMel, tempMFCC )

res1 = results(1,:);
res2 = results(2,:);
res3 = results(3,:);
tiledPlot(timeArray, plotTitles, figTitle, res1, res2, res3 )
%}
