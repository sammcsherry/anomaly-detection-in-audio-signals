# Using MATLAB Engine to call functions in Python 


import numpy
import matlab.engine 

audioFile = 'AudioFiles/jar.mp3'; #add test to check input string is of correct format
frameOverlapPercentage = 0.6;    #add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-4;          #in seconds

eng = matlab.engine.start_matlab()
audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration = eng.extractAudioData(audiofile,frameOverlapPercentage, frameDuration, nargout=5);

segments = eng.splitAudioData(audioData, sampleRate, 60, nargout=1);
numberOfSegments = segments.shape(1)

#remove silence at start of audio file:
audioData, startingDataPoint = eng.removeSilence(audioData, nargout=2);

tempFFT, tempMFCC, tempMEL = eng.fullRXD(audioData, frameOverlapLength, frameLength, sampleRate,  "ALL", nargout=3);

numberOfFrames = tempFFT.shape(1)

#is adjustment needed on the time array?
timeArray = eng.getTimeArray(numberOfFrames, frameDuration, frameLength, frameOverlapDuration, startingDataPoint, nargout=1);

#plot cleaned anomaly scores:
finalAnomalies1 = eng.cleanRXDwrapperFunc(tempFFT, .9, 10, nargout= 1)
finalAnomalies2 = eng.cleanRXDwrapperFunc(tempMEL, .9, 10, nargout = 1)
finalAnomalies3 = eng.cleanRXDwrapperFunc(tempMFCC, .9, 10, nargout = 1)


