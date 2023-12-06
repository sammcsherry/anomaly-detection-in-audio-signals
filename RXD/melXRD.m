function [anomalyVectorMELnorm] = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    [coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
    coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.
    anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
    anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
    [thresholdedDataMEL,q10, q90] = getThreshold(anomalyVectorMEL);
    cleanedAnomaliesMEL = cleanAnomalies(thresholdedDataMEL, q10, q90, N);
end