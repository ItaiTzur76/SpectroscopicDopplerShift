% Output:
%  orb_el - the orbital elements of Sisyphus, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - a matrix where each row represents an observation date
function[orb_el, dates] = sisyphus_orb
% Orbital elements taken from http://newton.dm.unipi.it/neodys/index.php?pc=1.1.0&n=1866
a = 1.89352; % AU
e = 0.538625;
omega = 63.557;
Pi = 293.075;
I = 41.193;
% tMJD = 55800.0; tJD = tMJD + 2400000.5; % from http://wise-obs.tau.ac.il/~eran/Wise/Util/Julian_Day.html
t = 2455800.5;
M = 333.752;
orb_el = [a, e, omega, Pi, I, M2tau(t, M, a)];
% Observation dates taken from http://newton.dm.unipi.it/~neodys2/mpcobs/1866.rwo
% Got to this page via http://newton.dm.unipi.it/neodys/index.php?pc=1.1.7.0&n=1866
dates = [2003 02 10.50091 ; 2003 03 12.47476 ; 2003 03 27.452505 ; 2003 04 11.38474 ; 2003 05 11.31071];
