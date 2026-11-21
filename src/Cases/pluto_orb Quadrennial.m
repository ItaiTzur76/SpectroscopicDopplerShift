% Output:
%  orb_el - the orbital elements of Pluto, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - a matrix where each row represents an observation date
function[orb_el, dates] = pluto_orb
% Orbital elements taken from http://hamilton.dm.unipi.it/astdys/index.php?pc=1.1.0&n=134340
a = 39.5104; % AU
e = 0.248289;
omega = 110.312;
Pi = 114.223;
I = 17.136;
% tMJD = 55600.0; tJD = tMJD + 2400000.5; % from http://wise-obs.tau.ac.il/~eran/Wise/Util/Julian_Day.html
t = 2455600.5;
M = 30.712;
orb_el = [a, e, omega, Pi, I, M2tau(t, M, a)];
% Observation dates taken from http://hamilton.dm.unipi.it/~astdys/mpcobs/numbered/134/134340.rwo
% Got to this page via http://hamilton.dm.unipi.it/astdys/index.php?pc=1.1.7.0&n=134340
dates = [1936 01 17.5836 ; 1940 01 15.3111 ; 1942 01 16.17631 ; 1944 01 18.06883 ; 1948 01 14.20501];
