% Input:
%  orb_el - a structure containing the orbital elements as follows:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  t_ast (n1*1) - astrometric observation times
%  t_dop (n2*1) - Doppler observation times
%  ra (n1*1) - right-ascension guesses in degrees
%  dec (n1*1) - declination guesses in degrees
%  dop (n2*1) - Doppler-shift guesses in km/s
%  e_ra (n1*1) - expected errors in right-ascensions in degrees
%  e_dec (n1*1) - expected errors in declinations in degrees
%  e_dop (n2*1) - expected errors in Doppler-shifts in km/s
% Output (scalar): chi-squared error of guesses, according to equation 6.1 from "Statistics" by Roger Barlow
function[error] = chi2(orb_el, t_ast, t_dop, ra, dec, dop, e_ra, e_dec, e_dop)
[raOrb, decOrb, dopOrb] = ast_orb(orb_el, t_ast, t_dop);
% Squared relative errors:
sre_ra = ((ra - raOrb) ./ e_ra) .^ 2;
sre_dec = ((dec - decOrb) ./ e_dec) .^ 2;
sre_dop = ((dop - dopOrb) ./ e_dop) .^ 2;
error = sum(sre_ra(:)) + sum(sre_dec(:)) + sum(sre_dop(:));
