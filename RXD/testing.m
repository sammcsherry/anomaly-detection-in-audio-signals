
audiofile = 'C:\Users\sofia\OneDrive\Desktop\Audiofiles\jar.mp3';


[x, fs] = audioread(audiofile);
% resample:
fsin    = fs;
fsout   = 22050;
m       = lcm(fsin,fsout);
up      = m/fsin;
down    = m/fsout;
x_22    = resample(x, up, down);
audiowrite([audiofile,'_22050','.wav'], x_22, fsout);
% convert to PCM 16 bit
fid     = fopen([audiofile,'_22050','.wav'], 'r'); % Open wav file
wF      = fread (fid, inf, 'int16');% 16-bit signed integer
fwrite(wF,'short');
fclose(fid);