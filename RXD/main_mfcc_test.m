clear;
close all;

%data = feature_vector(audiofile, number_of_vectors, frame_duration);
[data, fs] = audioread('random.mp3');
data = data(:, 1);
% Define frame size and overlap in samples
frame_duration = 10*1e-3;
frame_length = round(frame_duration* fs); % For a 25 ms window
frame_overlap = round(5*1e-3 * fs); % For a 15 ms overlap

[coeffs, delta, deltaDelta, loc] = mfcc(data, fs, 'WindowLength', frame_length, 'OverlapLength', frame_overlap);

average_vector = mean(coeffs, 1);
covariance_matrix = cov(coeffs);
anomaly_vector = zeros(1, size(coeffs, 2));

for i = 1:size(coeffs(:,1))
    diff_vector = coeffs(i, :) - average_vector;
    anomaly_vector(i) = sqrt((diff_vector / covariance_matrix )* diff_vector');
end
number_of_frames = size(coeffs(:,1));
length_of_sample = number_of_frames*frame_duration;

time_array = frame_duration:frame_duration:length_of_sample;

plot(time_array, anomaly_vector)
figure;
imagesc(coeffs')
axis xy;
xlabel('frame number')
ylabel('MFCC')
colorbar;
title('MFCC')
clim([-15 15]);

%plot thresholded data 
thresholded_data = get_threshold(anomaly_vector, time_array);