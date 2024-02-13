function testPCAsnr(audioData, frameLength, frameOverlapLength)
    
    varianceThreshold = (50:100).'; %change this range first 
    npts = length(varianceThreshold);
    SNR = zeros(size(varianceThreshold)); % in decibels

    for  i = 1:npts 
       varThreshold = varianceThreshold(i);
       %not sure why passing "varianceThreshold(i)" direnctly into the function doesnt work but it is what it is
      
       % [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, varThreshold);
        [anomalyVectorFFTnorm] = fftXRDTESTTTTT(audioData, frameLength, frameOverlapLength, varThreshold);
       
       %this SNR is relative to a sinusoidal carrier: 
       SNR(i) = snr(anomalyVectorFFTnorm); % given in dBc (decibels relative to the carrier)
    end

    [pks,locs] = findpeaks(SNR);
    figure, plot(varianceThreshold, SNR, '-o'), hold on;
    title('SNR against Variance Threshold'),
    xlabel('Variance Threshold [%]'), ylabel('SNR [dBc]'), % dBc (decibels relative to the carrier)
    hold on, plot((varianceThreshold(1) + locs), pks, '*', 'Color', 'red');
    hold off;
    
end