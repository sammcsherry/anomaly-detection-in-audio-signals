%NOTE: 
% Each frame is represented as a row. This is due to the MFCC output.
%feature_vector currently not in use, so don't worry about its unit testing
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER DEFINED INPUTS:
audiofile = 'AudioFiles/random.mp3';          %add test to check input string is of correct format
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-3;         %in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[audioData,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile,frameOverlapPercentage, frameDuration);
%audioData = normalize(audioData);

%FFT
coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);

%mel Spectorgram
[coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.

%mfcc
[coeffsMFCC, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength, LogEnergy='append');

anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);

%normaize:
anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
anomalyVectorMFCCnorm = normalize(anomalyVectorMFCC, 'range');

summing =  (1/3).*((0.5.*anomalyVectorFFTnorm ) + anomalyVectorMELnorm + anomalyVectorMFCCnorm );
figure, plot(summing), title('sum');

%{
%Following comment is to converge the domains.
fft = anomalyVectorFFT;
mfcc = anomalyVectorMEL;
mel = anomalyVectorMFCC;
result = conv(fft, mfcc, 'full');
allDomains = conv(result, mel, 'full'); 
figure, plot(allDomains), title('all domains!!');


allDomains2 = fft.*mfcc.*mel;
figure, plot(allDomains2), title('all domains 2 !!');
%}

numberOfFrames = size(coeffsMFCC,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);


%plotAnomalyScores(timeArray, anomalyVectorFFTnorm)
%plotAnomalyScores(timeArray(12:end), anomalyVectorMELnorm(12:end))
%plotAnomalyScores(timeArray, anomalyVectorMFCCnorm)

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


%plot thresholded data 
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
