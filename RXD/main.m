clear;

audiofile = 'tapping.mp3';
number_of_vectors = 500; %number of desired feature vectors
frame_duration = 10*1e-3; % in seconds (frame is a collection of samples)
length_of_sample = number_of_vectors*frame_duration;

data = feature_vector(audiofile, number_of_vectors, frame_duration);

average_vector = get_average_vector(data, number_of_vectors);
covariance_matrix = get_covariance_matrix(data, average_vector, number_of_vectors);

anomaly_vector = zeros(1, number_of_vectors);

for i = 1:number_of_vectors
    anomaly_vector(i) = calculate_RXD(data(i,:), covariance_matrix, average_vector);
end

time_array = frame_duration:frame_duration:length_of_sample;
anomaly_vector;
plot(time_array, anomaly_vector)