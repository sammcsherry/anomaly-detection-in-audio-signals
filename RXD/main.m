%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked')

addpath('AudioFiles\')
addpath('Pre-Processing\')
addpath('RXD\')
addpath('Post Processing\')
addpath('Miscellaneous\')
addpath('Results\')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER DEFINED INPUTS:
% 1kHzSinPureTone.mp3
audioFile = '1kHzSinWithSquares.wav'; %add test to check input string is of correct format
frameOverlapPercentage = 0.8;   %decimal
frameDuration = 0.009;           %seconds

if frameOverlapPercentage<0 || frameOverlapPercentage>1
    error('Variable "frameOverlapPercentage" must be a numerical value between 0 and 1.')
end
%add check: frameDuration > sampleRate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extractAudioData(audioFile,frameOverlapPercentage, frameDuration);

%remove silence at start of audio file:
[audioData, startingDataPoint] = removeSilence(audioData);

%preprocessing for Jar:
%startingDataPoint = 1;
%processJar = processJarData(audioData, sampleRate);
%audioData = processJar;


%[tempFFT] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "FFT");
[tempPCA] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "PCA", 8);
  

%[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MFCC");
%[tempMel] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MEL");
%[tempFFT, tempMFCC, tempMel] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");
%[results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");
% ^ just an example of variable outputs, does the same as current line -2 (two above)

numberOfFrames = size(tempFFT,2); 

%is adjustment needed on the time array?
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

%plot cleaned anomaly scores:
finalAnomalies1 = cleanRXDWrapperFunc(tempFFT, .9, 10);
finalAnomalies2 = cleanRXDWrapperFunc(tempMel, .9, 10);
finalAnomalies3 = cleanRXDWrapperFunc(tempMFCC, .9, 10);
plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Clean Anomalies vs Time";
xLabels = ["Time (s)", "Time (s)", "Time (s)"]; % "jank for now will fix later" - Adam
yLabels = ["Clean Anomalies", "Clean Anomalies", "Clean Anomalies"]; % "had to do it to em" - Adam
%tiledPlot(timeArray, plotTitles, figTitle, xLabels, yLabels, tempFFT, tempMel, tempMFCC)
tiledPlot(timeArray, plotTitles, figTitle, xLabels, yLabels, finalAnomalies1, finalAnomalies2, finalAnomalies3)
%tabulatedResults = tabulateAnomalies(timeArray, plotTitles, finalAnomalies1, finalAnomalies2, finalAnomalies3);

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

audioFiles = AudioFiles(); 
anomalyData = audioFiles.getFileData(audioFile); 


[POD, PFA] = metricFunc(timeArray, finalAnomalies1, anomalyData) ;
disp("FFT:"); disp(["POD:", POD]); disp(["PFA:", PFA]);

[POD, PFA] = metricFunc(timeArray, finalAnomalies2, anomalyData) ;
disp("MEL:"); disp(["POD:", POD]); disp(["PFA:", PFA]);

[POD, PFA] = metricFunc(timeArray, finalAnomalies3, anomalyData) ;
disp("MFCC:");  disp(["POD:", POD]); disp(["PFA:", PFA]);