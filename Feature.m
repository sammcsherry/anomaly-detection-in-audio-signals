classdef Feature < handle
    % Holds one features of the audio data

    properties
        data
        length
        histogramBinHeights
        histogramBinEdges
    end

    methods
        function obj = Feature(data, dataLength)
            % initialisation function
            [heights, edges] = histcounts(data, 'Normalization','probability');
            obj.data = data;
            obj.length = dataLength;
            obj.histogramBinHeights = heights;
            obj.histogramBinEdges = edges;
        end
    end
end