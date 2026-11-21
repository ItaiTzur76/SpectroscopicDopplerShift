% Input:
%  orb_el - a structure containing the orbital elements as follows:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  ra (n1*1) - right-ascension guesses in degrees
%  dec (n1*1) - declination guesses in degrees
%  dop (n2*1) - Doppler-shift guesses in km/s
%  t_ast (n1*1) - astrometric observation times
%  t_dop (n2*1) - Doppler observation times
%  e_dop (n2*1) - expected errors in Doppler-shifts in km/s
%  tol - tolerance parameter for TolFun and TolX in fminsearch
%  minIterations - minimum number of iterations
% Output:
%  result - a matrix similar to orb_el in size containing the orbital
%  elements calculated by applying chi2 on gen_obs results
%  iterations - the number of iterations performed by fminsearch
function[result, iterations] = test_chi2(orb_el, ra, dec, dop, t_ast, t_dop, e_dop, tol, minIterations)
arcsecond = 1 / 3600; % number of degrees in an arcsecond
z_ast = zeros(size(t_ast, 1), 1);
arcsec = z_ast + arcsecond;
options = optimset('MaxFunEvals', 1e9, 'MaxIter', 1e9, 'TolFun', tol, 'TolX', tol);
previous = orb_el;
while true
    [result, fval, exitflag, output] = ...
        fminsearch(@chi2, orb_el, options, t_ast, t_dop, ra, dec, dop, arcsec, arcsec, e_dop);
    iterations = output.iterations;
    if iterations >= minIterations || isequal(result, previous)
        break
    end
    orb_el = result * 2 - orb_el;
    previous = result;
end
