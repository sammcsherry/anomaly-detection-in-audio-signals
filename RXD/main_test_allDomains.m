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
frameDuration = 100e-3;         %in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);
segments = splitAudioData(audioData, sampleRate, 60);
numberOfSegments = size(segments,2);

%remove silence at start of audio file:
[audioData, startingDataPoint] = removeSilence(audioData);

[tempFFT] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "FFT");
[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MFCC");
[tempMel] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MEL");
[results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");

numberOfFrames = size(tempFFT,2); 

randomAnomalyTimes = [7.2, 108.8, 111.1, 117.1];
randomAnomalyWidths = [1.2, 1.1, 0.6, 1.1];
tappingAnomalyTimes = [44.2, 42.8];
tappingAnomalyWidths = [1.7, 2.6];

fitness = fitnessFunction(tempFFT, sampleRate, randomAnomalyTimes, randomAnomalyWidths)

%is adjustment needed on the time array?
timeArray = getTimeArray(numberOfFrames, frameDuration, frameLength, frameOverlapDuration, startingDataPoint);

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
