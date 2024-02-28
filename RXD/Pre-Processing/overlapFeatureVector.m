function vectors = overlapFeatureVector(audioData, frameDuration, overlapDuration, sampleRate)
    frameLength = round(frameDuration * sampleRate);
    overlapLength = round(overlapDuration * sampleRate);

    % Create overlapping frames with windowing
    frames = buffer(audioData, frameLength, overlapLength, 'nodelay');
    frames = frames .* hamming(frameLength);

    % Transpose frames to have each frame as a row
    vectors = frames.';
end
