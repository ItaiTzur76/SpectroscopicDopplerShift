% Plot the locations of a given object during its tests
% Input: parameters describing the desired object:
%  results - a (nx6) matrix in which each row contains calculated orbital
%  elements of the object, with the following columns:
%   result(: , 1) - semi-major axes in AU
%   result(: , 2) - eccentricities
%   result(: , 3) - longitudes of ascending node in degrees
%   result(: , 4) - arguments of perihelion in degrees
%   result(: , 5) - inclinations in degrees
%   result(: , 6) - times of perihelion passage
%  iterations - a (5xn) matrix in which each column contains the number of
%  iterations performed by fminsearch for each of the 5 test types
function plot_spread(results, iterations)
rows = size(results(:, :, 1));
columns = rows(2);
rows = rows(1);
rep = [1 , 1 , size(results, 3)];
for row = 1 : rows
	for column = 1 : columns
		subplot(rows, columns, (row - 1) * columns + column)
		results = (results - repmat(permute(mean(permute(results, [3 1 2])), [2 3 1]), rep)) ./ repmat(permute(std(permute(results, [3 1 2])), [2 3 1]), rep);
		plot([iterations(row, :); iterations(row, :)], [permute(results(row, column, :), [1 3 2]); permute(results(row, column, :), [1 3 2])])
		if row == 1
			switch column
				case 1
					title('a')
				case 2
					title('e')
				case 3
					title('Omega')
				case 4
					title('w')
				case 5
					title('I')
				otherwise
					title('T')
			end
		end
	end
end
