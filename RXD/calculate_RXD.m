function RXD = calculate_RXD(vector,covariance_matrix, average_vector)
    RXD = sqrt(abs((vector - average_vector)*((covariance_matrix^(-1))*(vector - average_vector).' )));
end