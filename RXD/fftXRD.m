function [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, varargin)
    if length(varargin) == 1
        varianceThreshold = varargin{1};
    end

    coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);
    
    % only perform PCA if varianceThreshold is provided
    if ~isempty(varianceThreshold)
        coeffsFFT = performPCA(coeffsFFT, varianceThreshold);
    end
    
    anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
    anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
end