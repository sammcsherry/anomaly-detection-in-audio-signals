
function segments = splitAudioData(audioData, sampleRate, windowLength)
    % Calculate how many samples in 1 minute of audio
    samplesPerMinute = sampleRate * windowLength;

    % Calculate the number of 1-minute segments in the audio
    numSegments = ceil(length(audioData) / samplesPerMinute);

    % Cell array to store the segments
    segments = cell(1, numSegments);

    % Split the audio into 1 minute segments
    for i = 1:numSegments
        startIndex = (i - 1) * samplesPerMinute + 1;
        endIndex = min(i * samplesPerMinute, length(audioData));
        segments{i} = audioData(startIndex:endIndex);
    end
end
