function [audio_data,sampleRate] = extract_audio_data(audiofile, numberOfFrames, frameDuration)
    [y, ~] = audioread(audiofile);
   
    if size(y, 2) == 2
        % take one channel
        y = y(:, 1);
    end

    audio_info = audioinfo(audiofile);
    sampleRate = extractfield(audio_info, 'SampleRate');

    % Truncate the audio data
    finish = numberOfFrames * frameDuration * sampleRate;
    audio_data = y(1:finish);
end
