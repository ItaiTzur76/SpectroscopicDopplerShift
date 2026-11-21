% Output:
%  orb_el - the orbital elements of Eros, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - a matrix where each row represents an observation date
function[orb_el, dates] = eros_orb
% Orbital elements taken from http://newton.dm.unipi.it/neodys/index.php?pc=1.1.0&n=433
a = 1.45803; % AU
e = 0.222848;
omega = 304.365;
Pi = 178.738;
I = 10.829;
% tMJD = 55600.0; tJD = tMJD + 2400000.5; % from http://wise-obs.tau.ac.il/~eran/Wise/Util/Julian_Day.html
t = 2455600.5;
M = 167.622;
orb_el = [a, e, omega, Pi, I, M2tau(t, M, a)];
% Observation dates taken from http://newton.dm.unipi.it/~neodys/mpcobs/433.rwo
% Got to this page via http://newton.dm.unipi.it/neodys/index.php?pc=1.1.7.0&n=433
dates = [2010 01 26.68581 ; 2010 02 26.72806 ; 2010 03 11.45980 ; 2010 03 27.69234 ; 2010 04 26.81647];
