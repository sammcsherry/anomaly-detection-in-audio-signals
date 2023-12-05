function [] = fullRXD(audioFile, frameOverlapPercentage, frameDuration, methodFlag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[audioData,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audioFile,frameOverlapPercentage, frameDuration);
sampleRate
frameLength
%audioData = normalize(audioData);

N = 10; %left and right cells to average - used for removing noise

switch methodFlag
    case "FFT"
        
    case "MEL"
        [coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
        coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.
        anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
        anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
        [thresholdedDataMEL,sMEL] = get_threshold(anomalyVectorMEL);
        cleanedAnomaliesMEL = cleanAnomalies(thresholdedDataMEL, sMEL, N);
    case "MFCC"
        [coeffsMFCC, delta, deltaDelta, loc] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength, LogEnergy='append');
        anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);
        anomalyVectorMFCCnorm = normalize(anomalyVectorMFCC, 'range');
        [thresholdedDataMFCC,sMFCC] = get_threshold(anomalyVectorMFCC);
        cleanedAnomaliesMFCC = cleanAnomalies(thresholdedDataMFCC,sMFCC, N);
    otherwise
        "no flag detected using MEL"
        [coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
        coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.
        anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
        anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
        [thresholdedDataMEL,sMEL] = get_threshold(anomalyVectorMEL);
        cleanedAnomaliesMEL = cleanAnomalies(thresholdedDataMEL, sMEL, N);
end

numberOfFrames = size(coeffsMFCC,1);
timeArray = getTimeArray(numberOfFrames, frameDuration, frameOverlapDuration);



%summing =  (1/3).*((0.5.*anomalyVectorFFTnorm ) + anomalyVectorMELnorm + anomalyVectorMFCCnorm );
%figure, plot(summing), title('sum');

% %Following comment is to converge the domains.
% fft = anomalyVectorFFT;
% MFCC = anomalyVectorMEL;
% mel = anomalyVectorMFCC;
% result = conv(fft, MFCC, 'full');
% allDomains = conv(result, mel, 'full'); 
% figure, plot(allDomains), title('all domains!!');
% 
% allDomains2 = fft.*MFCC.*mel;
% figure, plot(allDomains2), title('all domains 2 !!');

%plotAnomalyScores(timeArray, anomalyVectorFFTnorm)
%plotAnomalyScores(timeArray(12:end), anomalyVectorMELnorm(12:end))
%plotAnomalyScores(timeArray, anomalyVectorMFCCnorm)


end