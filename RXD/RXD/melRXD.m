function [anomalyVectorMELnorm] = melRXD(audioData, sampleRate, frameLength, frameOverlapLength)

    [coeffsMEL, ~, ~] = melSpectrogram(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength);
    coeffsMEL = coeffsMEL'; % melSpectrogram does coloums as frames so must be transposed.
    anomalyVectorMEL = calculateMahalanobis(coeffsMEL);
    anomalyVectorMELnorm = normalize(anomalyVectorMEL, 'range');
end