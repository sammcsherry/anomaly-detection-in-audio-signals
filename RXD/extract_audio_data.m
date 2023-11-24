function [data,sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extract_audio_data(audiofile, frameOverlapPercentage, frameDuration)
    [data, sampleRate] = audioread(audiofile);
    frameLength = round(frameDuration* sampleRate);
    

    frameOverlapLength = round(frameOverlapPercentage*frameLength);
    frameOverlapDuration = frameOverlapLength/sampleRate;
    if size(data, 2) == 2
        % take one channel
        data = data(:, 1);
    end
end
