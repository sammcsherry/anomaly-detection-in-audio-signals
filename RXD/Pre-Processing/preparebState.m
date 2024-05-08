function [bState] = preparebState(audioData, frameLength,frameOverlapLength)

    frames = buffer(audioData, frameLength, frameOverlapLength, 'nodelay');
    frames = frames(:, 1:end-1);
    window = hamming(frameLength);
    frames = bsxfun(@times, frames, window);
    test = size(frames)

    bState = mean(frames, 2);
    bState = bState / norm(bState);
    bState = bState';

    %{
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
    %}
end