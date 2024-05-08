function [anomalyVector] = calculateMahalanobis(coeffs)
    averageVector = mean(coeffs, 1);
    epsilon = 1e-6;  % Small constant
    covarianceMatrix = cov(coeffs) + epsilon * eye(size(coeffs, 2));

    % Base file name
    base_file_name = 'cov_matrix.txt';
    file_name = base_file_name;
    % Check if the file already exists
    counter = 1;
    while exist(file_name, 'file')
        % Append a digit to the file name
        file_name = [base_file_name(1:end-4) '_' num2str(counter) '.txt'];
        counter = counter + 1;
    end
    % Write the matrix to the file
    dlmwrite(file_name, covarianceMatrix, 'delimiter', '\t');
    disp(['Matrix written to ' file_name]);




    delta = coeffs - averageVector;
    anomalyVector = sqrt(sum((delta*pinv(covarianceMatrix)) .* delta, 2)).';

end