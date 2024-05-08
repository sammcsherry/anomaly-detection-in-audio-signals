function [fitness, timeTaken] = sweepFrameDuration(audioFile, frameDurations, domain, anomalyTimes, anomalyWidths)
% Performs a parameter sweep of the framelength variable to find the most
% performant in anomaly detection accuracy 
frameOverlapPercentage = 0.6;   %add test to check this is defined as a decimal between 0<= x < 1
fitness = zeros(length(frameDurations), 1);
timeTaken = zeros(length(frameDurations), 1);
index = 0;
for frameDuration = frameDurations
    index = index + 1;
    tic;
    [audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration] = extractAudioData(audioFile,frameOverlapPercentage, frameDuration);
    [audioData, ~] = removeSilence(audioData);
    [results] = fullRXD(audioData, frameOverlapLength, frameLength, sampleRate, domain);
    timeTaken(index) = toc;
    timeArray = getTimeArray(length(results), frameDuration, frameOverlapDuration);
    fitness(index) = fitnessFunction(results, anomalyTimes, anomalyWidths, timeArray);
end
end