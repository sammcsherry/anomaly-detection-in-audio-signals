function timeArray = getTimeArray(numberOfFrames, frameDuration, overlapDuration, startingDataPoint)
    timeStep = frameDuration - overlapDuration;
    timeArray = (startingDataPoint-1:numberOfFrames-1) * timeStep;
end
