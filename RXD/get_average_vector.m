function average_vector = get_average_vector(matrix, number_of_vectors)
    length_of_vector = length(matrix(1, :));
    average_vector = (1/number_of_vectors)*sum(matrix(:,1:length_of_vector));
end