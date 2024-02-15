# Using MATLAB Engine to call functions in Python 


import numpy
import matlab.engine 

audiofile = 'AudioFiles/jar.mp3'; #add test to check input string is of correct format
frameOverlapPercentage = 0.6;    #add test to check this is defined as a decimal between 0<= x < 1
frameDuration = 25e-4;          #in seconds

eng = matlab.engine.start_matlab()
audioData, sampleRate, frameLength, frameOverlapLength, frameOverlapDuration = eng.feval("extract_audio_data", audiofile,frameOverlapPercentage, frameDuration, nargout=5);

segments = eng.feval("splitAudioData",audioData, sampleRate, 60, nargout=1);
numberOfSegments = segments.shape(1)

#remove silence at start of audio file:
audioData, startingDataPoint = eng.feval("removeSilence", audioData, nargout=2);

tempFFT, tempMFCC, tempMEL = eng.feval("fullRXD", audioData, frameOverlapLength, frameLength, sampleRate,  "ALL", nargout=3);

numberOfFrames = tempFFT.shape(1)

#is adjustment needed on the time array?
timeArray = eng.feval("getTimeArray", numberOfFrames, frameDuration, frameLength, frameOverlapDuration, startingDataPoint, nargout=1);

#plot cleaned anomaly scores:
finalAnomalies1 = eng.feval ("cleanRXDwrapperFunc", tempFFT, .9, 10, nargout= 1)
finalAnomalies2 = eng.feval ("cleanRXDwrapperFunc", tempMEL, .9, 10, nargout = 1)
finalAnomalies3 = eng.feval ("cleanRXDwrapperFunc", tempMFCC, .9, 10, nargout = 1)


