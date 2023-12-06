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

%[results, timeArray] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate, "MEL");
%[results, timeArray] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "MFCC");
[results, timeArray] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate,  "ALL");
figure, plotAnomalyScores(timeArray, results, "test");

%{
figure('Name','Anomalies vs Time');
tiledlayout(1,3);
hold on;
nexttile
plotAnomalyScores(timeArray, anomalyVectorFFT, 'FFT anomalies against time')
nexttile
plotAnomalyScores(timeArray, anomalyVectorMEL, 'Mel Spectrogram anomalies against time')
nexttile
plotAnomalyScores(timeArray, anomalyVectorMFCC,'MFCC anomalies against time')
%~~~~~~~~


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
% %matlab smoothed data function? test 
% cleanedAnomaliesV2FFT = cleanAnomaliesV2(thresholdedDataFFT);
% cleanedAnomaliesV2MEL = cleanAnomaliesV2(thresholdedDataMEL);
% cleanedAnomaliesV2MFCC = cleanAnomaliesV2(thresholdedDataMFCC);
% 
% figure('Name','Anomalies cleaned V2');
% tiledlayout(1,3);
% hold on;
% 
% nexttile
% plotAnomalyScores(timeArray, cleanedAnomaliesV2FFT, 'FFT anomalies against time with threshold with noise reduction V2')
% nexttile
% plotAnomalyScores(timeArray, cleanedAnomaliesV2MEL, 'Mel Spectrogram anomalies against time with threshold with noise reduction V2')
% nexttile
% plotAnomalyScores(timeArray, cleanedAnomaliesV2MFCC,'MFCC anomalies against time with threshold with noise reduction V2')
% %~~~~~~~~
%}