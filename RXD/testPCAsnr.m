function testPCAsnr(audioData, frameLength, frameOverlapLength)
    
    varianceThreshold = (50:100).'; %change this range if desired
    npts = length(varianceThreshold);
    SNR = zeros(size(varianceThreshold)); % in dBc - decibels relative to carrier
    PSNR = zeros(size(varianceThreshold)); % in dB - decibels

    %for PSNR acquisition method: (only works for 'tapping.mp3')

    refSignal = zeros(1,70115); 

    %anomaly 1 pos: 
    a1min = round(1000*(42.8 - 2.6)); 
    a1max = round(1000*(42.8 + 2.6)); 

    %anomlay 2 pos: 
    a2min = round(1000*(44.2 - 1.7)); 
    a2max = round(1000*(44.2 + 1.7)); 

    %magnitude of each anomaly: 
    %mag1 = mean(audioData(a1min:a1max)); 
    %mag2 = mean(audioData(a2min:a2max)); 
    mag1 = 1;
    mag2 = 1;

    %generate "reference signal": 
    refSignal(a1min:a1max) = mag1; 
    refSignal(a2min:a2max) = mag2; 

 
    for  i = 1:npts 
       [anomalyVectorFFTnorm] = fftXRD(audioData, frameLength, frameOverlapLength, varianceThreshold(i));
       
       %this SNR is relative to a sinusoidal carrier: 
       SNR(i) = snr(anomalyVectorFFTnorm); % given in dBc (decibels relative to the carrier)

       %the PSNR is calculated relative to a synthetic reference audio signal, which I made based on anomaly instances given by Thales:  
       %% PSNR IS ONLY FOR "TAPPING" 
       PSNR(i) = psnr(anomalyVectorFFTnorm, refSignal); 

    end

    [pks,locs] = findpeaks(SNR);
    figure, plot(varianceThreshold, SNR, '-o'), hold on;
    title('SNR against Variance Threshold'),
    xlabel('Variance Threshold [%]'), ylabel('SNR [dBc]'), % dBc (decibels relative to the carrier)
    hold on, plot((varianceThreshold(1) + locs), pks, '*', 'Color', 'red');
    hold off;

    [pks,locs] = findpeaks(PSNR);
    figure, plot(varianceThreshold, PSNR, '-o'), hold on;
    title('PSNR against Variance Threshold'),
    xlabel('Variance Threshold [%]'), ylabel('PSNR [dB]'), % dB (decibels)
    hold on, plot((varianceThreshold(1) + locs), pks, '*', 'Color', 'red');
    hold off;
    
end