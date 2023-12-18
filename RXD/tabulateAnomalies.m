function tabulatedResults = tabulateAnomalies(timeArray, headings, varargin)
    n = size(varargin,2);
    anomalies = zeros(length(timeArray), 1);    
    tabulatedResults = ();
    for col = 1:n
        data = varargin{col};
        idx = find(data > 0);
        temp = timeArray(idx);
        anomalies(1:length(temp)) = temp;
        tabulatedResults = horzcat(tabulatedResults, anomalies);
    end
    %tabulatedResults = vertcat(headings, tabulatedResults);
    tabulatedResults = table(vertcat(headings, tabulatedResults);
end