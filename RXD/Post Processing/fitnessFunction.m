function [cost] = fitnessFunction(anomalies, expectedAnomalyTimes, expectedAnomalyWidths, timeArray)
% Finds how close the detected anomalies

cost = 0;
for frame = 1:length(anomalies)
    time = timeArray(frame);
    for index = 1:length(expectedAnomalyTimes)
        anomalyLowerBound = expectedAnomalyTimes(index) - expectedAnomalyWidths(index)/2;
        anomalyUpperBound = expectedAnomalyTimes(index) + expectedAnomalyWidths(index)/2;
        if time > anomalyLowerBound && time < anomalyUpperBound
            cost = cost + anomalies(frame);
        else
            cost = cost - anomalies(frame);
        end
    end
end
end