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
%  e_ra (n1*1) - expected errors of right-ascensions in degrees
%  e_ra (n1*1) - expected errors of declinations in degrees
%  e_ra (n2*1) - expected errors of Doppler-shifts
% Output: observations normally spread around the exact coordinates according to the expected error distribution
function[ra, dec, dop] = gen_obs(orb_el, t_ast, t_dop, e_ra, e_dec, e_dop)
[raOrb, decOrb, dopOrb] = ast_orb(orb_el, t_ast, t_dop);
ra = spread(raOrb, e_ra);
dec = spread(decOrb, e_dec);
dop = spread(dopOrb, e_dop);
