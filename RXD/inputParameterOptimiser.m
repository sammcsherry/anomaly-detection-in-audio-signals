function inputParameterOptimiser(audioData, sampleRate knownAnomalyInstances, domain)

    %call function to generate reference audio:
    refSignal = %call func here

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
    heatMap = zeros(length(frameOverlapPercentage), length(frameDuration));
    

    [audioData, sampleRate, frameLength, frameOverlapLength, ~] = extract_audio_data(audioFile,frameOverlapPercentage, frameDuration);
    [audioData, ~] = removeSilence(audioData);
           
    %cycle through each combination
    %matrix notation used: Aij, i = row, j = column
    for i = frameDuration
        for j = frameOverlapPercentage
            [results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain)
            
        end
    end
    %add condiiton: if it does not compute put 1 as a value 
end


