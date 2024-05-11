% function that removes the silence present at the start of the audio
% files
function [preProcessedData, startingDataPoint] = removeSilence(audioData)
    counter = 0;
    for i = 1:length(audioData)
        if audioData(i) == 0
            counter = counter + 1;
        else 
            break
        end
    end
    startingDataPoint = counter+1;
    preProcessedData = audioData(startingDataPoint:end);
end
