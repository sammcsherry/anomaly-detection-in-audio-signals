function [anomalyVectorMFCCnorm] = mfccRXD(audioData, sampleRate, frameLength, frameOverlapLength)

    [coeffsMFCC, ~, ~, ~] = mfcc(audioData, sampleRate, 'WindowLength', frameLength, 'OverlapLength', frameOverlapLength, LogEnergy='append');
    anomalyVectorMFCC = calculateMahalanobis(coeffsMFCC);
    anomalyVectorMFCCnorm = normalize(anomalyVectorMFCC, 'range');
end