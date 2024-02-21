classdef AudioFiles
    properties (Access = private)
        audioMap containers.Map
    end
    
    methods
        function obj = AudioFiles()
            %Dictionary
            obj.audioMap = containers.Map('KeyType', 'char', 'ValueType', 'any');      
            obj.audioMap('10534_SSW_20170429.ogg') = struct('AnomalyCentreTimes', [84.3, 321.5, 442.3], 'AnomalyDuration', [1.8, 1.3, 1.7]);
            obj.audioMap('11254_COR_20190904.ogg') = struct('AnomalyCentreTimes', [417.5], 'AnomalyDuration', [2.2]);
            obj.audioMap('jar.mp3') = struct('AnomalyCentreTimes', [46.9, 47.4, 48], 'AnomalyDuration', [0.5, 0.5, 0.5]);
            obj.audioMap('random.mp3') = struct('AnomalyCentreTimes', [7.2, 108.8, 111.1, 117.1], 'AnomalyDuration', [1.2, 1.1, 0.6, 1.1]);
            obj.audioMap('tapping.mp3') = struct('AnomalyCentreTimes', [44.2, 42.8], 'AnomalyDuration', [1.7, 2.6]);
        end
        
        % Access data for a specific file
        function data = getFileData(obj, fileName)
            if isKey(obj.audioMap, fileName)
                data = obj.audioMap(fileName);
            else
                error('File not found.');
            end
        end
    end
end
