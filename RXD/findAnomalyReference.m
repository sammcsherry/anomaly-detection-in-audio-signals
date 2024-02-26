% Is this function used and what for as the team and I are confused as to
% what folder to match this to - Cyrus \(^_^)/
function [anomalyReference] = findAnomalyReference(audioData, anomalyTimes, anomalyRanges, frameLength, sampleRate, frameOverlapLength)
    [numElements,~] = size(audioData);
    totalTime = numElements/sampleRate;
    frames = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
    frames = frames(:, 1:end-1);
    numFrames = size(frames, 2);
    numAnomalies = size(anomalyTimes, 2);
    anomalyReference = zeros(numFrames, 1);
    for index = 1:numAnomalies
       anomalyPosition = anomalyTimes(index)/totalTime;
       anomalyFrame = ceil(anomalyPosition*numFrames);
       anomalyFrameRange = ceil((anomalyRanges(index)*sampleRate)/frameLength);
       anomalyReference(anomalyFrame:anomalyFrame+anomalyFrameRange) = 1;
       anomalyReference(anomalyFrame:anomalyFrame-anomalyFrameRange) = 1;
    end
    anomalyReference = anomalyReference';
end