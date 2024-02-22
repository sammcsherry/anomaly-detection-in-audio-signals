function [probOfDetection, probOfFalseAlarm] = metricFunc(audioLength, anomalies, anomalyData)
%UNTITLED2 Summary of this function goes here

timeStep = audioLength / length(anomalies);
detectedAnomalies = 0;
falseAnomalies = 0;
totalAnomalousDataPoints = 0;
for frame = 1:length(anomalies)
    time = timeStep * frame;
    for index = 1:length(anomalyData.AnomalyCentreTimes)
        anomalyLowerBound = anomalyData.AnomalyCentreTimes(index) - anomalyData.AnomalyDuration(index)/2;
        anomalyUpperBound = anomalyData.AnomalyCentreTimes(index) + anomalyData.AnomalyDuration(index)/2;
        if time > anomalyLowerBound && time < anomalyUpperBound
            if anomalies(frame) > 0
                detectedAnomalies = detectedAnomalies + 1;
            end
            totalAnomalousDataPoints = totalAnomalousDataPoints + 1;
        else
            if anomalies(frame) > 0
                falseAnomalies = falseAnomalies + 1;
            end
        end
    end
end

probOfDetection = detectedAnomalies/totalAnomalousDataPoints;
probOfFalseAlarm = falseAnomalies/length(anomalies);
end