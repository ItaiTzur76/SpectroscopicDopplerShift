% Input: parameters describing the desired object:
%  orb_el - the object's orbital elements, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - observation date for the object, consisting of the following:
%   dates(1, :) - given observation date
%   dates(2, :) - observation date approximately 30 days after dates(1,:)
%   dates(3, :) - observation date approximately 45 days after dates(1,:)
%   dates(4, :) - observation date approximately 60 days after dates(1,:)
%   dates(5, :) - observation date approximately 90 days after dates(1,:)
%  n - the desired number of tests to perform
%  tol - tolerance parameter for TolFun and TolX in fminsearch
%  minIterations - 5-element vector of the minimum number of iterations for
%  each type of test
% Output:
%  result - a (nx6) matrix in which each row contains calculated orbital
%  elements of the object, with the following columns:
%   result(: , 1) - semi-major axes in AU
%   result(: , 2) - eccentricities
%   result(: , 3) - longitudes of ascending node in degrees
%   result(: , 4) - arguments of perihelion in degrees
%   result(: , 5) - inclinations in degrees
%   result(: , 6) - times of perihelion passage
%  iterations - a (5xn) matrix in which each column contains the number of
%  iterations performed by fminsearch for each of the 5 test types
function [result, iterations] = test_n(orb_el, dates, n, tol, minIterations)
result = [];
iterations = [];
jdate3 = juliandate(dates(3,:));
t_ast4 = juliandate([dates(5,:) ; dates(4,:) ; dates(2,:) ; dates(1,:)]);
t_ast5 = juliandate([dates(5,:) ; dates(4,:) ; dates(3,:) ; dates(2,:) ; dates(1,:)]);
arcsecond = 1 / 3600; % number of degrees in an arcsecond
for i = 1 : n
    [ra, dec, dop] = gen_obs(orb_el, t_ast5, [jdate3 ; jdate3 ; jdate3], arcsecond, arcsecond, [0.001 ; 0.01 ; 0.1]);
    ra4 = [ra(1) ; ra(2) ; ra(4) ; ra(5)];
    dec4 = [dec(1) ; dec(2) ; dec(4) ; dec(5)];

    [r1, i1] = test_chi2(orb_el, ra4, dec4, zeros(0, 1), t_ast4, zeros(0, 1), zeros(0, 1), tol, minIterations(1));
    [r2, i2] = test_chi2(orb_el, ra, dec, zeros(0, 1), t_ast5, zeros(0, 1), zeros(0, 1), tol, minIterations(2));
    [r3, i3] = test_chi2(orb_el, ra4, dec4, dop(1), t_ast4, jdate3, 0.001, tol, minIterations(3));
    [r4, i4] = test_chi2(orb_el, ra4, dec4, dop(2), t_ast4, jdate3, 0.01, tol, minIterations(4));
    [r5, i5] = test_chi2(orb_el, ra4, dec4, dop(3), t_ast4, jdate3, 0.1, tol, minIterations(5));

    result = cat( 3 , result , [r1 ; r2 ; r3 ; r4 ; r5] );
    iterations = [iterations , [i1 ; i2 ; i3 ; i4 ; i5] ];
end
