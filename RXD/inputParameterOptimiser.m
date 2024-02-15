%function inputs:
%audioFile = "tapping.mp3";
%audioPath = "AudioFiles/" + audioFile;
%domain = "MFCC";

function inputParameterOptimiser(audioFile, domain)

    %Note: domain can only be MFCC, MEL or FFT (Does not work for "ALL")
    if domain == "all"
        disp("ERROR: domain can only be 'MFCC', 'MEL', or 'FFT'.")
    else 
   
        %call function to generate reference audio:
       % refSignal = %call func here
    
        %set parameters over which to sweep:
    
        %Frame duration sweep
        minFD = 5*10e-5; %change to variable later, depending on sample rate of file
        maxFD = 0.01; %change to variable later, depending on run time?? 
        dt = 5*10e-5;
        
        %Frame overlap percentage sweep
        minFOP = 0;
        maxFOP = 0.9;
        dp = 0.1;
    
        frameDuration = minFD:dt:maxFD;
        frameOverlapPercentage = minFOP:dp:maxFOP;
    
        %initialise matrix: y axis: overlap %, xaxis, frameduration
        heatMapSNR = zeros(length(frameOverlapPercentage), length(frameDuration));    
        heatMapPSNR = zeros(length(frameOverlapPercentage), length(frameDuration));
    
        %cycle through each combination
        %matrix notation used: Aij, i = row, j = column
        for i = 1:length(frameDuration)
            for j = 1:length(frameOverlapPercentage)

                %VERIFY THESE TWO LINES:
                [audioData, sampleRate, frameLength, frameOverlapLength, ~] = extract_audio_data(audioFile, frameOverlapPercentage(j), frameDuration(i));
                [audioData, ~] = removeSilence(audioData);
                [anomalyVector] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain);
                
                %SNR is relative to a sinusoidal carrier: 
                heatMapSNR(i,j) = snr(anomalyVector); % given in dBc (decibels relative to the carrier)
    
                %PSNR is calculated relative to a synthetic reference audio signal, based on known anomaly instances given by Thales:  
          %      heatMapPSNR(i,j) = psnr(anomalyVector, refSignal); 
            end
        end
        %Display heat map:(FIX AXIS)
        x = [frameDuration(1), frameOverlapPercentage(end)];
        y = [frameDuration(end), frameOverlapPercentage(1)];
        figure, imagesc(x, y, heatMapSNR), hold on;
        xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),
        title('Reuslts SNR for varying input parameters'),        
        axis tight,
        colormap(gca,hot),
        colorbar, %label the colorbar as SNR
        hold off;
    end
end


