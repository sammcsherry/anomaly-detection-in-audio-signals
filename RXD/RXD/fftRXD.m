function [anomalyVectorFFTnorm] = fftRXD(audioData, frameLength, frameOverlapLength, varargin)
    if length(varargin) == 1
        numComponents = varargin{1};
    end

    coeffsFFT = calculateFFT(audioData, frameLength, frameOverlapLength);
    
    % only perform PCA if varianceThreshold is provided
    if ~isempty(varargin)
        coeffsFFT = performPCA(coeffsFFT, numComponents);
    end
    anomalyVectorFFT = calculateMahalanobis(coeffsFFT);
    anomalyVectorFFTnorm = normalize(anomalyVectorFFT, 'range');
end