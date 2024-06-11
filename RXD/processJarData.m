function processJar = processJarData(audioData, sampleRate)
    fourierTransform = fft(audioData, sampleRate);
    fourierTransform = fftshift(fourierTransform);
    figure, plot(real(fourierTransform)), title("fft jar");
    fourierTransform_processed = fourierTransform;
    fourierTransform_processed(2.2*1e4:2.6*1e4) = 0.01;
    processJar = ifft(fourierTransform_processed);
    %make real
    processJar = real(processJar);
    figure, plot(audioData), title("original data");
    figure, plot(processJar), title("preprocessed jar data")
end
