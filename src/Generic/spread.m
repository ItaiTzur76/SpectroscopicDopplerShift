% Input:
%  matrix (n*m) - a regular matrix of numbers
%  errors (n*m) - expected errors in the matrix
% Output (n*m): a matrix of numbers normally spread around the given matrix according to the given error distribution
function[result] = spread(matrix, errors)
result = matrix + errors .* randn(size(matrix));
