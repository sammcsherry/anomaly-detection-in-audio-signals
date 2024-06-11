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
audioFile = '1kHzSinWithSquares.wav';
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

[tempPCA] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "PCA", 8);
[tempFFT, tempMFCC, tempMel] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");

% uncomment for other examples:
%[tempFFT] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "FFT");
%[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MFCC");
%[tempMel] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MEL");

numberOfFrames = size(tempPCA,2); 
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);

%plot cleaned anomaly scores:
finalAnomalies1 = cleanRXDWrapperFunc(tempFFT, .9, 10);
finalAnomalies2 = cleanRXDWrapperFunc(tempMel, .9, 10);
finalAnomalies3 = cleanRXDWrapperFunc(tempMFCC, .9, 10);
plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Clean Anomalies vs Time";
xLabels = ["Time (s)", "Time (s)", "Time (s)"]; 
yLabels = ["Clean Anomalies", "Clean Anomalies", "Clean Anomalies"]; 
tiledPlot(timeArray, plotTitles, figTitle, xLabels, yLabels, finalAnomalies1, finalAnomalies2, finalAnomalies3)

%plot PCA results
figure, plot(timeArray, tempPCA), title('PCA'), xlabel("Time (s)"), ylabel("Clean Anomalies");


%Get POD and PFA values:
audioFiles = AudioFiles(); 
anomalyData = audioFiles.getFileData(audioFile); 


[POD, PFA] = metricFunc(timeArray, finalAnomalies1, anomalyData) ;
disp("FFT:"); disp(["POD:", POD]); disp(["PFA:", PFA]);

[POD, PFA] = metricFunc(timeArray, finalAnomalies2, anomalyData) ;
disp("MEL:"); disp(["POD:", POD]); disp(["PFA:", PFA]);

[POD, PFA] = metricFunc(timeArray, finalAnomalies3, anomalyData) ;
disp("MFCC:");  disp(["POD:", POD]); disp(["PFA:", PFA]);