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
    
        %Frame duration sweep
  %      minFD = 5*10e-5; 
  %      maxFD = 0.01005;  
  %      dt = 1*10e-5;

        minFD = 0.0001; 
        maxFD = 0.01; 
        dt = 0.0003;

        %Frame overlap percentage sweep
        minFOP = 0.1;
        maxFOP = 0.5;
        dp = 0.1;
    
        frameDuration = minFD:dt:maxFD;
        disp(frameDuration)
        frameOverlapPercentage = maxFOP:-dp:minFOP;
        %disp(frameOverlapPercentage)

        %initialise matrix: y axis: overlap %, xaxis, frameduration
        heatMapSNR = zeros(length(frameOverlapPercentage), length(frameDuration));  

        %generate synthetic signal for PSNR
        audioClass = AudioFiles();
        anomalyTimes = audioClass.getFileData(audioFile).AnomalyCentreTimes;
        anomalyRanges = audioClass.getFileData(audioFile).AnomalyDuration;
        heatMapPSNR = zeros(length(frameOverlapPercentage), length(frameDuration));
        
        %cycle through each combination
        %matrix notation used: Aij, i = column, j=row
        for i = 1:length(frameDuration)
            for j = 1:length(frameOverlapPercentage)
                
                %fprintf('window lenght %.1f ', i)
                [audioData, sampleRate, frameLength, frameOverlapLength, ~] = extractAudioData(audioPath, frameOverlapPercentage(j), frameDuration(i));
                [audioData, ~] = removeSilence(audioData);
                [anomalyVector] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain);
                
                numFrames = length(anomalyVector);
                %SNR is relative to a sinusoidal carrier: 
                heatMapSNR(j,i) = snr(anomalyVector); % given in dBc (decibels relative to the carrier)
    
                %PSNR is calculated relative to a synthetic reference audio signal, based on known anomaly instances given by Thales:  
                refSignal = findAnomalyReference(audioData, anomalyTimes, anomalyRanges, frameLength, sampleRate, numFrames);
              %  fprintf('anomaly %.0f, ref %.0f', size(anomalyVector,1), size(refSignal,1))
                heatMapPSNR(j,i) = psnr(anomalyVector, refSignal); 
                
                warning('off')
            end
        end
       % disp(size(frameDuration))
       % disp(size(frameOverlapPercentage))
       % disp(size(heatMapSNR))


        %% FIX IMAGING CODE AND ENSURE AXIS ORIENTATION IS CORRECT
        %Display heat map:(FIX AXIS)
      %  x = [frameDuration(1), frameOverlapPercentage(end)];
      %  y = [frameDuration(end), frameOverlapPercentage(1)];
      %  figure, imagesc('XData', x, 'YData', y, 'CData', heatMapSNR), hold on;
       % heatmap(frameDuration, frameOverlapPercentage.', heatMapSNR);
       % xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),
       % title('Reuslts SNR for varying input parameters'),        
        %axis tight,
       % colormap(gca,hot),
       % colorbar, %label the colorbar as SNR
        %hold off;

        %{
        %Display heat map:(FIX AXIS)
        x = [frameDuration(1), frameOverlapPercentage(end)];
        y = [frameDuration(end), frameOverlapPercentage(1)];
        figure, imagesc(heatMapPSNR), hold on;
        xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),
        title('Reuslts SNR for varying input parameters'),        
        axis tight,
        colormap(gca,hot),
        colorbar, %label the colorbar as SNR
        hold off;
        %}

     %   figure, hold on;
      %  heatmap(frameDuration, frameOverlapPercentage,heatMapSNR);
      %  xlabel('Frame Duration [s]'), ylabel('Frame overlap percentage'),
      %  title('Reuslts SNR for varying input parameters'), 
       % colormap('hot')
       % colorbar;
      %  hold off;

       figure, imagesc(heatMapPSNR), title('psnr')
       figure, imagesc(heatMapSNR), title('snr')

    end
end


