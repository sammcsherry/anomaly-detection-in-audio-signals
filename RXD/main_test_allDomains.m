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
%[audioData, startingDataPoint] = removeSilence(audioData);
startingDataPoint = 1;
%note: need help changing time array to match removing silnece

[tempFFT] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate, "FFT");
[tempMFCC] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "MFCC");
[tempMel] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "MEL");
[results] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "ALL");

numberOfFrames = size(tempFFT,2); %how can we genralise this?
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration, startingDataPoint);

plotTitles = ["FFT", "Mel", "MFCC"];
figTitle = "Anomalies vs Time";
%tiledPlot(timeArray, plotTitles, figTitle, tempFFT, tempMel, tempMFCC )

res1 = results(1,:);
res2 = results(2,:);
res3 = results(3,:);
tiledPlot(timeArray, plotTitles, figTitle, res1, res2, res3 )


%{


% %plot thresholded data 
[thresholdedDataFFT,sFFT] = get_threshold(anomalyVectorFFT);
[thresholdedDataMEL,sMEL] = get_threshold(anomalyVectorMEL);
[thresholdedDataMFCC,sMFCC] = get_threshold(anomalyVectorMFCC);

figure('Name','Anomalies with threshold');
tiledlayout(1,3);
hold on;

nexttile
plotAnomalyScores(timeArray, thresholdedDataFFT, 'FFT anomalies against time with threshold')
nexttile
plotAnomalyScores(timeArray, thresholdedDataMEL, 'Mel Spectrogram anomalies against time with threshold')
nexttile
plotAnomalyScores(timeArray, thresholdedDataMFCC,'MFCC anomalies against time with threshold')
%~~~~~~~~


%remove noise from detected anomalies
N = 10; %left and right cells to average
cleanedAnomaliesFFT = cleanAnomalies(thresholdedDataFFT, sFFT, N);
cleanedAnomaliesMEL = cleanAnomalies(thresholdedDataMEL, sMEL, N);
cleanedAnomaliesMFCC = cleanAnomalies(thresholdedDataMFCC,sMFCC, N);

figure('Name','Anomalies cleaned');
tiledlayout(1,3);
hold on;

nexttile
plotAnomalyScores(timeArray, cleanedAnomaliesFFT, 'FFT anomalies against time with threshold with noise reduction')
nexttile
plotAnomalyScores(timeArray, cleanedAnomaliesMEL, 'Mel Spectrogram anomalies against time with threshold with noise reduction')
nexttile
plotAnomalyScores(timeArray, cleanedAnomaliesMFCC,'MFCC anomalies against time with threshold with noise reduction')
%~~~~~~~~

%}
