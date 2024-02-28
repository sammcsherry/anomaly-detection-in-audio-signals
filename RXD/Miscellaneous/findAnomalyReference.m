% Is this function used and what for as the team and I are confused as to
% what folder to match this to - Cyrus \(^_^)/
% it's used to find the ideal signal so that we can perform signal to noise
% ratio which requires a reference signal
function anomalyReference = findAnomalyReference(audioData, anomalyTimes, anomalyRanges, frameLength, sampleRate, numFrames)
    totalTime = length(audioData) / sampleRate;
    frameTime = frameLength / sampleRate;
    anomalyReference = zeros(numFrames, 1);
    
    for index = 1:length(anomalyTimes)
       startFrame = max(1, floor((anomalyTimes(index) / totalTime) * numFrames));
       endFrame = min(numFrames, startFrame + ceil((anomalyRanges(index) / frameTime)));
       anomalyReference(startFrame:endFrame) = 1;
    end
    anomalyReference = anomalyReference';
end
