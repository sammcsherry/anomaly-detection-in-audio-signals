function timeArray = getTimeArray(numberOfFrames, frameDuration, overlapDuration, startingDataPoint)
    timeStep = frameDuration - overlapDuration;
    timeArray = (0:numberOfFrames-1) * timeStep;
  %  timeArray = timeArray + startingDataPoint * timeStep;
end
