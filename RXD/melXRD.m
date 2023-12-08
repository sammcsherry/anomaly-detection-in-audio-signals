function [anomalyVectorMELnorm] = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N, setThreshold)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    [coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
    coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.
    anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
    anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
end