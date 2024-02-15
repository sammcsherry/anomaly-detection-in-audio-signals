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
        dt = 1*10e-5;
        
        %Frame overlap percentage sweep
        minFOP = 0;
        maxFOP = 0.9;
        dp = 0.1;
    
        frameDuration = minFD:dt:maxFD;
        frameOverlapPercentage = minFOP:dp:maxFOP;
    
        %initialise matrix: y axis: overlap %, xaxis, frameduration
        heatMapSNR = zeros(length(frameOverlapPercentage), length(frameDuration));    
        heatMapPSNR = zeros(length(frameOverlapPercentage), length(frameDuration));
    
        %VERIFY THESE TWO LINES:
        [audioData, sampleRate, frameLength, frameOverlapLength, ~] = extract_audio_data(audioFile,frameOverlapPercentage, frameDuration);
        [audioData, ~] = removeSilence(audioData);
               
        %cycle through each combination
        %matrix notation used: Aij, i = row, j = column
        for i = frameDuration
            for j = frameOverlapPercentage
                [anomalyVector] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain);
                
                %SNR is relative to a sinusoidal carrier: 
                heatMapSNR(i,j) = snr(anomalyVector); % given in dBc (decibels relative to the carrier)
    
                %PSNR is calculated relative to a synthetic reference audio signal, based on known anomaly instances given by Thales:  
          %      heatMapPSNR(i,j) = psnr(anomalyVector, refSignal); 
            end
        end
        %Display heat map:

        figure, imagesc(heatMapSNR), hold on;
        xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),
        title('final SNR for varying input parameters')
        colorbar
        hold off;
        %add condiiton: if it does not compute put 1 as a value 
    end
end


