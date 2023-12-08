function [results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, methodFlag)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    %audioData = normalize(audioData);
    %segmentSize = size(audioData)
    N = 10; %left and right cells to average - used for removing noise
    setThreshold = 0.9;
    switch methodFlag
        case "FFT"
            results = fftXRD(audioData, frameLength, frameOverlapLength, N, setThreshold);
            finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
        case "MEL"
            results = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N, setThreshold);
            finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
        case "MFCC"
            results = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength, N, setThreshold);
            finalAnomalies = cleanRXDwrapperFunc(results, setThreshold, N);
        case "ALL"
            tempFFT = fftXRD(audioData, frameLength, frameOverlapLength, N, setThreshold);
            tempMel = melXRD(audioData, sampleRate, frameLength, frameOverlapLength, N, setThreshold);
            tempMFCC = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength, N, setThreshold);
            results = [tempFFT; tempMel; tempMFCC];

            finalAnomaliesTempFFT = cleanRXDwrapperFunc(tempFFT,setThreshold, N);
            finalAnomaliesTempMel = cleanRXDwrapperFunc(tempMel,setThreshold, N);
            finalAnomaliesTempMFCC = cleanRXDwrapperFunc(tempMFCC, setThreshold,N);
            finalAnomalies = [finalAnomaliesTempFFT; finalAnomaliesTempMel; finalAnomaliesTempMFCC];
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