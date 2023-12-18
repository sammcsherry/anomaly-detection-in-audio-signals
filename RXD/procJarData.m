function procJar = procJarData(audioData, sampleRate)
    ft = fft(audioData, sampleRate);
    ft = fftshift(ft);
    figure, plot(real(ft)), title("fft jar");
    ft_processed = ft;
    ft_processed(2.2*1e4:2.6*1e4) = 0.01;
    procJar = ifft(ft_processed);
    %make real?
    procJar = real(procJar);
    figure, plot(audioData), title("original data");
    figure, plot(procJar), title("preprocessed jar data")
end
