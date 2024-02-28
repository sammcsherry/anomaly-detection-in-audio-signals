function [data,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extractAudioData(audioFile, frameOverlapPercentage, frameDuration)
    [data, sampleRate] = audioread(audioFile);
    frameLength = round(frameDuration* sampleRate);
    frameOverlapLength = round(frameOverlapPercentage*frameLength);
    frameOverlapDuration = frameOverlapLength/sampleRate;
    if size(data, 2) == 2
        % take one channel
        data = data(:, 1);
    end
end
