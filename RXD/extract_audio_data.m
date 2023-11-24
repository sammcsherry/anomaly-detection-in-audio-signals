function [data,sampleRate, frameLength] = extract_audio_data(audiofile, frameDuration)
    [data, sampleRate] = audioread(audiofile);
    frameLength = round(frameDuration* sampleRate);
   
    if size(data, 2) == 2
        % take one channel
        data = data(:, 1);
    end
end
