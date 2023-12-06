function [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, N)
% performs the steps of xrd with fft processing
coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);
anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
[thresholdedDataFFT,sFFT] = get_threshold(anomalyVectorFFT);
cleanedAnomaliesFFT = cleanAnomalies(thresholdedDataFFT, sFFT, N);
end