function [reducedData] = performPCA(data, numComponents)
    %explained variance refers to the amount of variance captured by the principle components
    [~, score, ~, ~, ~] = pca(data);
    % determine number of components to retain based on the variance threshold
    %cumulativeVariance = cumsum(explainedVariance);
    % returns first index where threshold is met
    %numComponents = find(cumulativeVariance >= varianceThreshold, 1, 'first');
    % truncate data based on number of principle components calculated
    reducedData = score(:, 1:numComponents);
    
    disp(['hi'])
    ifdjghiodshfboisdfdrd
    %get b state and write to file
    bStateMean = mean(reducedData, 1);
    disp(size(data))

    %initialise empty bStateArray.
    %each col is one bState vector. 

    bStateArray = zeros(numComponents, size(data,1)); % is this (data,1 or 2)???
    
    for frame_num = 1:size(data,1) % is this 1 or 2 (rows or cols)
        bState = bStateMean - data(:,frame_num); %data(frame_num, :) ;
        
        bState = bState / norm(bState);
        bState = bState';

        bStateArray(:,frame_num) = bState;

    end

    
    base_file_name = 'b_vector.txt';
    file_name = base_file_name;
    
    counter = 1;
    while exist(file_name, 'file')
        file_name = [base_file_name(1:end-4) '_' num2str(counter) '.txt'];
        counter = counter + 1;
    end
    dlmwrite(file_name, bState, 'delimiter', '\t');
    disp(['Matrix written to ' file_name]);
    
end