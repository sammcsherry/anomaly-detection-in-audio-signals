function [covariance_matrix] = get_covariance_matrix(data, average_vector, number_of_vectors)
    covariance_matrix = 1/(number_of_vectors-1)*(data-average_vector).'*(data-average_vector);
end