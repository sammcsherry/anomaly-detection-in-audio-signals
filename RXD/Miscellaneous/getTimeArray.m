function timeArray = getTimeArray(numberOfFrames, frameDuration, overlapDuration)
    timeStep = frameDuration - overlapDuration;
    timeArray = (0:numberOfFrames-1) * timeStep;

    % Needs to be removed I think - the boys
    %correction for removing silent audio at start:
    %correction = (startingDataPoint-1)*(frameDuration/frameLength);
    %timeArray = timeArray + correction;
end
