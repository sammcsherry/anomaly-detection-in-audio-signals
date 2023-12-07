function [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, N)
    % performs the steps of xrd with fft processing
    coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);
    anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
    anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
    [thresholdedDataFFT,q10, q90] = getThreshold(anomalyVectorFFT);
    cleanedAnomaliesFFT = cleanAnomalies(thresholdedDataFFT, q10, q90, N);
end