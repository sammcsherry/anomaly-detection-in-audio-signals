function [results] = fullRXD(audioData, frameOverlapLength, frameOverlapDuration, frameLength, frameDuration, sampleRate, methodFlag)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    %audioData = normalize(audioData);
    %segmentSize = size(audioData)
    N = 10; %left and right cells to average - used for removing noise
    switch methodFlag
        case "FFT"
            results = fftXRD(audioData, frameLength, frameOverlapLength, N);
        case "MEL"
            results = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N);
        case "MFCC"
            results = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength, N);
        case "ALL"
            tempFFT = fftXRD(audioData, frameLength, frameOverlapLength, N);
            tempMEL = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N);
            tempMFCC = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength, N);
            results = [tempFFT; tempMEL; tempMFCC];
    end
    
    %summing =  (1/3).*((0.5.*anomalyVectorFFTnorm ) + anomalyVectorMELnorm + anomalyVectorMFCCnorm );
    %figure, plot(summing), title('sum');
    
    % %Following comment is to converge the domains.
    % fft = anomalyVectorFFT;
    % MFCC = anomalyVectorMEL;
    % mel = anomalyVectorMFCC;
    % result = conv(fft, MFCC, 'full');
    % allDomains = conv(result, mel, 'full'); 
    % figure, plot(allDomains), title('all domains!!');
    % 
    % allDomains2 = fft.*MFCC.*mel;
    % figure, plot(allDomains2), title('all domains 2 !!');
    
    %plotAnomalyScores(timeArray, anomalyVectorFFTnorm)
    %plotAnomalyScores(timeArray(12:end), anomalyVectorMELnorm(12:end))
    %plotAnomalyScores(timeArray, anomalyVectorMFCCnorm)


end