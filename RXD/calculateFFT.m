function coeffs = calculateFFT(audioData, frameLength, frameOverlapLength)
    % split signal into frames
    frames = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
    frames = frames(:, 1:end-1);
    % apply windowing
    window = hamming(frameLength);
    windowedFrames = bsxfun(@times, frames, window);

    numFrames = size(windowedFrames, 2);
    coeffs = zeros(numFrames, frameLength / 2 + 1);

    % Perform FFT on each frame
    for i = 1:numFrames
        frameFFT = fft(windowedFrames(:, i), frameLength);
        coeffs(i, :) = abs(frameFFT(1:frameLength / 2 + 1));
    end
end
