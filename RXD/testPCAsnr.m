function testPCAsnr(audioData, frameLength, frameOverlapLength)
    
    varianceThreshold = (50:100).'; %change this range first 
    npts = length(varianceThreshold);
    SNR = zeros(size(varianceThreshold)); % in decibels
    
    for  i = 1:npts 
        [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, varianceThreshold(i));
        SNR(i) = snr(anomalyVectorFFTnorm);
    end
    [pks,locs] = findpeaks(SNR);
    figure, plot(varianceThreshold, SNR, '-o'), hold on, plot(pks, locs, '*', 'Color', 'red');
    
end
        
