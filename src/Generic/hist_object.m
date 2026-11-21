% Plot histograms of given tests for an object, per scenario and element
% Input: parameters describing the desired object:
%  results - a (nx6) matrix in which each row contains calculated orbital
%  elements of the object, with the following columns:
%   result(: , 1) - semi-major axes in AU
%   result(: , 2) - eccentricities
%   result(: , 3) - longitudes of ascending node in degrees
%   result(: , 4) - arguments of perihelion in degrees
%   result(: , 5) - inclinations in degrees
%   result(: , 6) - times of perihelion passage
%  nbins - the number of bins to be used by the hist function
function hist_object(results, nbins)
rows = size(results(:, :, 1));
columns = rows(2);
rows = rows(1);
for row = 1 : rows
	for column = 1 : columns
		subplot(rows, columns, (row - 1) * columns + column)
		hist((results(row, column, :) - mean(results(row, column, :))) / std(results(row, column, :)), nbins)
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
