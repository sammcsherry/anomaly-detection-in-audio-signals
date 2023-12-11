function [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength)
    % performs the steps of xrd with fft processing
    coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);
    anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
    anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
end