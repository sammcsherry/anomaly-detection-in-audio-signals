function [anomalyVectorMFCCnorm] = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength)
    %UNTITLED4 Summary of this function goes here
    %   Detailed explanation goes here
    [coeffsMFCC, ~, ~, ~] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength, LogEnergy='append');
    anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);
    anomalyVectorMFCCnorm = normalize(anomalyVectorMFCC, 'range');
end