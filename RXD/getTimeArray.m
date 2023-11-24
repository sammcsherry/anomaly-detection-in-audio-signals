function timeArray = getTimeArray(numberOfFrames, frameDuration, overlapDuration)
    timeStep = frameDuration - overlapDuration;
    timeArray = (0:numberOfFrames-1) * timeStep;
end
