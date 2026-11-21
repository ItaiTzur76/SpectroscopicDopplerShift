% Input: the desired number of tests to perform
% Output:
%  result - a (nx6) matrix in which each row contains calculated orbital
%  elements of Sisyphus, with the following columns:
%   result(: , 1) - semi-major axes in AU
%   result(: , 2) - eccentricities
%   result(: , 3) - longitudes of ascending node in degrees
%   result(: , 4) - arguments of perihelion in degrees
%   result(: , 5) - inclinations in degrees
%   result(: , 6) - times of perihelion passage
%  iterations - a (5xn) matrix in which each column contains the number of
%  iterations performed by fminsearch for each of the 5 test types
function [result, iterations] = test_sisyphus(n)
[original, dates] = sisyphus_orb;
[result, iterations] = test_n(original, dates, n, 1e-8, [470, 510, 450, 440, 440]);
