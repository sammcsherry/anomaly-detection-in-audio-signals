function vectors = feature_vector(audiofile, number_of_vectors, frame_duration )
    audio_info = audioinfo(audiofile);
    fs = extractfield(audio_info, 'SampleRate');
    frame_length = ceil(frame_duration * fs);
    start = 1;
    finish = frame_length * number_of_vectors ;
   % samples = [start, finish]; % code to read only a portion of the mp3 file
    [y, ~] = audioread(audiofile, 'native'); % samples);
    y1 = y(:,1);
    y2 = y(:,2);

    if y1 ~= y2
         disp('Error: MP3 channels are not equal')
    end

    audio_single_channel = y(:,1);
    extracted_audio = audio_single_channel(start:finish,:); 
    
    %matrix of feature vectors, each matrix row is one feature vector
    vectors = reshape(extracted_audio,[], number_of_vectors);
    vectors = vectors.';
    disp(size(vectors))

end