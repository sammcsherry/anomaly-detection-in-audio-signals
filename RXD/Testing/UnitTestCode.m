%% testing plotAnoamalyScores Function 
time = cumsum(ones(1000,1));
y = gaussmf(time,[50 50]);

plotAnomalyScores(time, y)

%% testing GetTimeArray Function
numberOfFrames = 2;
frameDuration = 1;
overlapDuration = 0.5;
timeArray = getTimeArray(numberOfFrames, frameDuration, overlapDuration);

%% testing extractAudioData Function - Using sound file customAnomalyTestData.wav
clear;
audioFile = '1kHzSinWithSquares.wav';
[audioData, sampleRate, ~, ~, ~] = extract_audio_data(audioFile, 0.5, 250e-3);
time = (1:length(audioData))./sampleRate;
plot(time, audioData)

%% testing calculateMahalanobis Function - Using sound files customAnomalyTestData.wav, 1kHzSinPureTone.mp3 - Using melSpectrogram
normalAudioFile = '1kHzSinPureTone.mp3';
anomalyAudioFile = '1kHzSinWithSquares.wav';

frameOverlapPercentage = 0.5;
frameDuration = 250e-3;
[audioData, sampleRate, frameLength, frameOverlapLength, ~] = extract_audio_data(anomalyAudioFile, frameOverlapPercentage, frameDuration);

[coeffs, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
coeffs = coeffs'; % melSpectrogram does coloums as frames so must be transposed.

averageVector = mean(coeffs, 1);
covariance_matrix = cov(coeffs);

anomalyScores = calculateAllMahalanobis(coeffs, averageVector, covariance_matrix);

plot(anomalyScores)
xlabel('Time (s)');
ylabel('Anomaly Score');
title('1kHzSinwithSquares.wav using melSpectrogram');

%% testing calculateMahalanobis Function - Using sound files customAnomalyTestData.wav, 1kHzSinPureTone.mp3 - Using mfcc
normalAudioFile = '1kHzSinPureTone.mp3';
anomalyAudioFile = '1kHzSinWithSquares.wav';

frameOverlapPercentage = 0.5;
frameDuration = 250e-3;
[audioData, sampleRate, frameLength, frameOverlapLength, ~] = extract_audio_data(anomalyAudioFile, frameOverlapPercentage, frameDuration);

[coeffs, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);

averageVector = mean(coeffs, 1);
covariance_matrix = cov(coeffs);

anomalyScores = calculateAllMahalanobis(coeffs, averageVector, covariance_matrix);

plot(anomalyScores)
xlabel('Time (s)');
ylabel('Anomaly Score');
title('1kHzSinwithSquares.wav using MFCC');

%% testing get_Threshold Function - Using guassian curve
clear;
time = linspace(1, 200, 200);
gaussianCurve = gaussmf(time, [5, 100]);
[trimmedGaussian, ~] = get_threshold(gaussianCurve, time);

hold on;
plot(time, trimmedGaussian)
plot(time, gaussianCurve)
hold off;




