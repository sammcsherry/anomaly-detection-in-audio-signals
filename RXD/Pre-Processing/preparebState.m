function [bState] = preparebState(audioData, frameLength,frameOverlapLength)
    % split signal into frames
    frames = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
    frames = frames(:, 1:end-1);
    % apply windowing
    window = hamming(frameLength);
    windowedFrames = bsxfun(@times, frames, window);
    bState = mean(windowedFrames, 2);
    bState = bState ./ norm(bState);
end