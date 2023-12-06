function [anomalyVectorMFCCnorm] = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength, N)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[coeffsMFCC, ~, ~, ~] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength, LogEnergy='append');
anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);
anomalyVectorMFCCnorm = normalize(anomalyVectorMFCC, 'range');
[thresholdedDataMFCC,q10, q90] = getThreshold(anomalyVectorMFCC);
cleanedAnomaliesMFCC = cleanAnomalies(thresholdedDataMFCC,q10, q90, N);
end