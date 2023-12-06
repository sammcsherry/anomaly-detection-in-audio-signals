function segments = splitAudioData(audioData, sampleRate, windowLength)
    % Calculate how many samples in 1 minute of audio
    samples_per_minute = sampleRate * windowLength;

    % Calculate the number of 1-minute segments in the audio
    num_segments = ceil(length(audioData) / samples_per_minute);

    % Cell array to store the segments
    segments = cell(1, num_segments);

    % Split the audio into 1 minute segments
    for i = 1:num_segments
        start_index = (i - 1) * samples_per_minute + 1;
        end_index = min(i * samples_per_minute, length(audioData));
        segments{i} = audioData(start_index:end_index);
    end
end
