function [anomalyScore] = calculateHBOS(sample, binHeights, binEdges)
% calculates the anomaly score using the HBOS algorithm
probability = 0;
for i = 1:length(binEdges)
    if sample < binEdges(i)
        probability = binHeights(i - 1);
        break
    end
end
anomalyScore = log(1/probability);
end