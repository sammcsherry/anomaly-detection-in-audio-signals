%{
%function inputs:
audioFile = "tapping.mp3";
audioPath = "AudioFiles/" + audioFile;
domain = "MFCC";
%}

function inputParameterOptimiser(audioFile, domain)
    
    audioPath = "AudioFiles/" + audioFile;

    %Note: domain can only be MFCC, MEL or FFT (Does not work for "ALL")
    if domain == "all"
        error("domain can only be 'MFCC', 'MEL', or 'FFT'.")
    else 
      
        %set parameters over which to sweep:
    
        %dynamic step range attempt:
        %{
        frameDuration = zeros(1, 20);        
        minFD = 1*10e-4; 
        maxFD = 0.1;  
        frameDuration(1) = minFD;
        frameDuration(end) = maxFD;
        n = 19;
        dt = (maxFD - minFD)/((n*(n+1))/2);
        dT = 0;
        for i = 2:(length(frameDuration)-1)            
            dT = dT + dt;
            frameDuration(i) = frameDuration(i-1) + dT;
        
        end
        %}
        
        %Frame duration sweep
        minFD = 0.0001; 
        maxFD = 0.01; 
        dt = 0.0005;        
        frameDuration = minFD:dt:maxFD;

        %Frame overlap percentage sweep
        minFOP = 0.05;
        maxFOP = 0.85;
        dp = 0.05;
        frameOverlapPercentage = maxFOP:-dp:minFOP;

        %initialise matrix: y axis: overlap %, xaxis, frameduration
        heatMapSNR = zeros(length(frameOverlapPercentage), length(frameDuration));  

        %generate synthetic signal for PSNR
        audioClass = AudioFiles();
        anomalyTimes = audioClass.getFileData(audioFile).AnomalyCentreTimes;
        anomalyRanges = audioClass.getFileData(audioFile).AnomalyDuration;
        heatMapPSNR = zeros(length(frameOverlapPercentage), length(frameDuration));
        
        %cycle through each combination
        for col = 1:length(frameDuration)
            for row = 1:length(frameOverlapPercentage)
                
                [audioData, sampleRate, frameLength, frameOverlapLength, ~] = extractAudioData(audioPath, frameOverlapPercentage(row), frameDuration(col));
                [audioData, ~] = removeSilence(audioData);
                [anomalyVector] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain);
                
                numFrames = length(anomalyVector);
                %SNR is relative to a sinusoidal carrier: 
                heatMapSNR(row,col) = snr(anomalyVector); % given in dBc (decibels relative to the carrier)
    
                %PSNR is calculated relative to a synthetic reference audio signal, based on known anomaly instances given by Thales:  
                refSignal = findAnomalyReference(audioData, anomalyTimes, anomalyRanges, frameLength, sampleRate, numFrames);
                heatMapPSNR(row,col) = psnr(anomalyVector, refSignal); 
                
                warning('off')
            end
        end
       
       %plot heat map:
       figure, imagesc(frameDuration, frameOverlapPercentage, heatMapPSNR), colorbar,
       title('Reuslts PSNR for varying input parameters'), set(gca,'YDir','normal'),
       xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),

       figure, imagesc(frameDuration, frameOverlapPercentage, heatMapSNR), title('snr'), colorbar,
       title('Reuslts SNR for varying input parameters'), set(gca,'YDir','normal'),
       xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),

    end
end

