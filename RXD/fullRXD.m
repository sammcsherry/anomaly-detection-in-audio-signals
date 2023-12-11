<<<<<<< Updated upstream
function [finalAnomalies] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, methodFlag)
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
=======
function [varargout] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, varargin)
% computes the RXD algorithm on input data
nRequiredArgs = 4;
>>>>>>> Stashed changes

% setting default values
N = 10; %left and right cells to average - used for removing noise
setThreshold = 0.9;

if nargin > nRequiredArgs
    for index = 1:size(varargin, 2)
        if ~isstring(varargin{index})
            continue
        end

        switch lower(varargin{index}) % makes cases non case sensitive
            case "setn"; N = int32(varargin{index + 1});
                if ~isinteger(N)
                    error("The input for N must be an Integer")
                end
            case "setthreshold"; setThreshold = varargin{index + 1};
                if ~isnumeric(setThreshold)
                    error("The input for setThreshold must be a numeric data type")
                end
            case "fft"
                results = fftXRD(audioData, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
            case "mel"
                results = melXRD(audioData, sampleRate, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
            case "mfcc"
                results = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results, setThreshold, N);
            case "all"
                tempFFT = fftXRD(audioData, frameLength, frameOverlapLength);
                tempMel = melXRD(audioData, sampleRate, frameLength, frameOverlapLength);
                tempMFCC = mfccXRD(audioData, sampleRate, frameLength, frameOverlapLength);
                results = [tempFFT; tempMel; tempMFCC];
                size(results)
                %finalAnomaliesTempFFT = cleanRXDwrapperFunc(tempFFT,setThreshold, N);
                %finalAnomaliesTempMel = cleanRXDwrapperFunc(tempMel,setThreshold, N);
                %finalAnomaliesTempMFCC = cleanRXDwrapperFunc(tempMFCC, setThreshold,N);
                %finalAnomalies = [finalAnomaliesTempFFT; finalAnomaliesTempMel; finalAnomaliesTempMFCC];
            case "cleananomalies"
                results = cleanRXDwrapperFunc(results, setThreshold, N);
            otherwise
                error("Unrecognised optional input given: " + varargin{index})
        end
    end
end

% handles variable number of output requests
if (nargout == 1)
    varargout{1} = results;
else
    for index = 1:nargout
        varargout{index} = results(index, :);
    end
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