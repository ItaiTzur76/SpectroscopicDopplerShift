% Input: the desired number of tests to perform
% Output:
%  result - a (nx6) matrix in which each row contains calculated orbital
%  elements of Ceres, with the following columns:
%   result(: , 1) - semi-major axes in AU
%   result(: , 2) - eccentricities
%   result(: , 3) - longitudes of ascending node in degrees
%   result(: , 4) - arguments of perihelion in degrees
%   result(: , 5) - inclinations in degrees
%   result(: , 6) - times of perihelion passage
%  iterations - a (5xn) matrix in which each column contains the number of
%  iterations performed by fminsearch for each of the 5 test types
function [result, iterations] = test_ceres(n)
[original, dates] = ceres_orb;
[result, iterations] = test_n(original, dates, n, 1e-7, [620, 620, 520, 600, 600]);
