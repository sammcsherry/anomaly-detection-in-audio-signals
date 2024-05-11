function [reducedData] = performPCA(data, numComponents)
    %explained variance refers to the amount of variance captured by the principle components
    [~, score, ~, ~, ~] = pca(data);
    % determine number of components to retain based on the variance threshold
    %cumulativeVariance = cumsum(explainedVariance);
    % returns first index where threshold is met
    %numComponents = find(cumulativeVariance >= varianceThreshold, 1, 'first');
    % truncate data based on number of principle components calculated
    reducedData = score(:, 1:numComponents);
    

    %get b state and write to file
    bState = mean(reducedData, 1);
    bState = bState / norm(bState);
    bState = bState';
    
    % Base file name
    base_file_name = 'b_vector.txt';
    file_name = base_file_name;
    % Check if the file already exists
    counter = 1;
    while exist(file_name, 'file')
        % Append a digit to the file name
        file_name = [base_file_name(1:end-4) '_' num2str(counter) '.txt'];
        counter = counter + 1;
    end
    % Write the matrix to the file
    dlmwrite(file_name, bState, 'delimiter', '\t');
    disp(['Matrix written to ' file_name]);
    
end