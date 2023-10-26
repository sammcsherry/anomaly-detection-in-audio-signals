%% random code for testing ideas
audiofile = 'C:\Users\sofia\OneDrive\Desktop\Audiofiles\jar.mp3';


[x, fs] = audioread(audiofile);

% Convert stereo to mono:
if size(x, 2) == 2
    x = mean(x, 2);
end

