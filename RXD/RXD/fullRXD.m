function [varargout] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, varargin)
% computes the RXD algorithm on input data
nRequiredArgs = 4;

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
                results = fftRXD(audioData, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
            case "mel"
                results = melRXD(audioData, sampleRate, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results,setThreshold, N);
            case "mfcc"
                results = mfccRXD(audioData, sampleRate, frameLength, frameOverlapLength);
                %finalAnomalies = cleanRXDwrapperFunc(results, setThreshold, N);
            case "all"
                tempFFT = fftRXD(audioData, frameLength, frameOverlapLength);
                tempMel = melRXD(audioData, sampleRate, frameLength, frameOverlapLength);
                tempMFCC = mfccRXD(audioData, sampleRate, frameLength, frameOverlapLength);
                [tempFFT, tempMel, tempMFCC] = zeroPaddingV2(tempFFT, tempMel, tempMFCC);
                results = {tempFFT, tempMel, tempMFCC};
                %results = zeroPadding(tempFFT, tempMel, tempMFCC);
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
        varargout{index} = results{index};
    end
end


  

end