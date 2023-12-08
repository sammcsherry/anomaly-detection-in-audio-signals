function [cost] = fitnessFunction(anomalies, sampleRate, expectedAnomalyTimes, expectedAnomalyWidths)
% Finds how close the detected anomalies
%   Detailed explanation goes here
cost = 0;
for frame = 1:length(anomalies)
    time = frame/sampleRate;
    for index = 1:length(expectedAnomalyTimes)
        anomalyLowerBound = expectedAnomalyTimes(index) - expectedAnomalyWidths(index);
        anomalyUpperBound = expectedAnomalyTimes(index) + expectedAnomalyWidths(index);
        if time > anomalyLowerBound || time < anomalyUpperBound
            cost = cost + anomalies(frame);
        else
            cost = cost - anomalies(frame);
        end
    end
end
end