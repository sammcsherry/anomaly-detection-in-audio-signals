function [bState] = preparebState(audioData, frameLength,frameOverlapLength)
    frames = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
    frames = frames(:, 1:end-1);
    window = hamming(frameLength);
    frames = bsxfun(@times, frames, window);
    test = size(frames)
    bState = mean(frames, 2);
    bState = bState / norm(bState);
    bState = bState';
end