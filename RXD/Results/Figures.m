% Various Plots from the audio vector 
  
%{
y1 = y(:,1);
y2 = y(:,2);

if y1 == y2
    disp('L and R speaker output equal')
else 
    disp(' 3D audio')
end
%}

[y_jar, fs_jar] = audioread('C:\Users\sofia\OneDrive\Desktop\Audiofiles\jar.mp3');
[y_tapping, fs_tapping] = audioread('C:\Users\sofia\OneDrive\Desktop\Audiofiles\tapping.mp3');
[y_random, fs_random] = audioread('C:\Users\sofia\OneDrive\Desktop\Audiofiles\random.mp3');


jar_inf = audioinfo('C:\Users\sofia\OneDrive\Desktop\Audiofiles\jar.mp3');
tapping_inf = audioinfo('C:\Users\sofia\OneDrive\Desktop\Audiofiles\tapping.mp3');
random_inf = audioinfo('C:\Users\sofia\OneDrive\Desktop\Audiofiles\random.mp3');


close all 

%% JAR:
figure('Name','Jar');
tiledlayout(2,2);
hold on;

nexttile
plot(y_jar(:,1)), title('Time Domain');

nexttile
fft_jar = fft(y_jar(:,1),fs_jar);
fft_shift_jar = fftshift(fft_jar);
plot(abs(fft_shift_jar).^2), title('Frequency Domain');

nexttile
imagesc(abs(fft_shift_jar).^2);



nexttile

M = 480;
L = 240;
g = hann(M,"periodic");
Ndft = M;

[s_jar, f_jar, t_jar ] = spectrogram(y_jar(:,1), g, L, Ndft, fs_jar, 'centered');
spectrogram(y_jar(:,1), fs_jar);
hold off;



%% TAPPING:
figure('Name','Tapping');
tiledlayout(2,2);
hold on;

nexttile
plot(y_tapping(:,1)), title('Time Domain');

nexttile
fft_tapping = fft(y_tapping(:,1),fs_tapping);
fft_shift_tapping = fftshift(fft_tapping);
plot(abs(fft_shift_tapping).^2), title('Frequency Domain');

nexttile
imagesc(abs(fft_shift_tapping).^2)

nexttile
[s_tapping, f_tapping, t_tapping ] = spectrogram(y_tapping(:,1), fs_tapping);
spectrogram(y_tapping(:,1), fs_tapping);
hold off;

%% RANDOM:
figure('Name','Random');
tiledlayout(2,2);
hold on;

nexttile
plot(y_random(:,1)), title('Time Domain');

nexttile
fft_random = fft(y_random(:,1),fs_random);
fft_shift_random = fftshift(fft_random);
plot(abs(fft_shift_random).^2), title('Frequency Domain');

nexttile
imagesc(abs(fft_shift_random).^2)

nexttile
[s_random, f_random, t_random ] = spectrogram(y_random(:,1), fs_random);
spectrogram(y_random(:,1), fs_random);

hold off;

