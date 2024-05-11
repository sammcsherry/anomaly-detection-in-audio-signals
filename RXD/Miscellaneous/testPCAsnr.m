%{
audiofile = 'AudioFiles/jar.mp3'; %add test to check input string is of correct format
frameOverlapPercentage = 0.6;  %decimal
frameDuration = 25e-4;         %seconds

[audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extractAudioData(audiofile,frameOverlapPercentage, frameDuration);

%remove silence at start of audio file:
[audioData, startingDataPoint] = removeSilence(audioData);
audioFile = 'tapping.mp3';
%}

function testPCAsnr(audioFile, audioData, frameLength, frameOverlapLength, sampleRate)

    varianceThreshold = (50:100).'; %change this range if desired
    nPoints = length(varianceThreshold);
    SNR = zeros(size(varianceThreshold)); % in dBc - decibels relative to carrier
    PSNR = zeros(size(varianceThreshold)); % in dB - decibels

    %for PSNR acquisition method:    
    audioClass = AudioFiles();
    anomalyTimes = audioClass.getFileData(audioFile).AnomalyCentreTimes;
    anomalyRanges = audioClass.getFileData(audioFile).AnomalyDuration;
    refSignal = findAnomalyReference(audioData, anomalyTimes, anomalyRanges, frameLength, sampleRate, frameOverlapLength);
 
    for  i = 1:nPoints 
       [anomalyVectorFFTnorm] = fftRXD(audioData, frameLength, frameOverlapLength, varianceThreshold(i));
       
       %this SNR is relative to a sinusoidal carrier: 
       SNR(i) = snr(anomalyVectorFFTnorm); % given in dBc (decibels relative to the carrier)

       %the PSNR is calculated relative to a synthetic reference audio signal, made using anomaly instances given by Thales:  
       PSNR(i) = psnr(anomalyVectorFFTnorm, refSignal); 

    end

    [peaks,locations] = findpeaks(SNR);
     figure, plot(varianceThreshold, SNR, '-o'), hold on;
    title('SNR against Variance Threshold'),
    xlabel('Variance Threshold [%]'), ylabel('SNR [dBc]'), % dBc (decibels relative to the carrier)
    hold on, plot((varianceThreshold(1) + locations), peaks, '*', 'Color', 'red');
    hold off;

    [peaks,locations] = findpeaks(PSNR);
    figure, plot(varianceThreshold, PSNR, '-o'), hold on;
    title('PSNR against Variance Threshold'),
    xlabel('Variance Threshold [%]'), ylabel('PSNR [dB]'), % dB (decibels)
    hold on, plot((varianceThreshold(1) + locations), peaks, '*', 'Color', 'red');
    hold off;
    
end