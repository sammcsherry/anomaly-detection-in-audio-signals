%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER DEFINED INPUTS:
% 1kHzSinPureTone.mp3
audiofile = 'AudioFiles/jar.mp3'; %add test to check input string is of correct format
frameOverlapPercentage = 0.6;  %decimal
frameDuration = 25e-4;         %seconds

if frameOverlapPercentage<0 || frameOverlapPercentage>1
    error('Variable "frameOverlapPercentage" must be a numerical value between 0 and 1.')
end
%add check: frameDuration > sampleRate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extractAudioData(audiofile,frameOverlapPercentage, frameDuration);

%remove silence at start of audio file:
[audioData, startingDataPoint] = removeSilence(audioData);

%preprocessing for Jar:
%startingDataPoint = 1;
%procJar = procJarData(audioData, sampleRate);
%audioData = procJar;


%[tempFFT] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, "FFT");
%[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MFCC");
%[tempMEL] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "MEL");
[tempFFT, tempMFCC, tempMEL] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");
%[results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL");
% ^ just an example of variable outputs, does the same as line 24 (two above)

numberOfFrames = size(tempFFT,2); 

%is adjustment needed on the time array?
timeArray = getTimeArray(numberOfFrames, frameDuration, frameLength, frameOverlapDuration, startingDataPoint);

%plot cleaned anomaly scores:
finalAnomalies1 = cleanRXDwrapperFunc(tempFFT, .9, 10);
finalAnomalies2 = cleanRXDwrapperFunc(tempMEL, .9, 10);
finalAnomalies3 = cleanRXDwrapperFunc(tempMFCC, .9, 10);
plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Clean Anomalies vs Time";
xLabels = ["Time (s)", "Time (s)", "Time (s)"]; % "jank for now will fix later" - Adam
yLabels = ["Clean Anomalies", "Clean Anomalies", "Clean Anomalies"]; % "had to do it to em" - Adam
%tiledPlot(timeArray, plotTitles, figTitle, xLabels, yLabels, tempFFT, tempMEL, tempMFCC)
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
