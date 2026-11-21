% Output:
%  orb_el - the orbital elements of Ceres, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - a matrix where each row represents an observation date
function[orb_el, dates] = ceres_orb
% Orbital elements taken from http://hamilton.dm.unipi.it/astdys/index.php?pc=1.1.0&n=1
a = 2.76541; % AU
e = 0.079008;
omega = 80.392;
Pi = 72.525;
I = 10.587;
% tMJD = 55600.0; tJD = tMJD + 2400000.5; % from http://wise-obs.tau.ac.il/~eran/Wise/Util/Julian_Day.html
t = 2455600.5;
M = 156.36;
orb_el = [a, e, omega, Pi, I, M2tau(t, M, a)];
% Observation dates taken from http://hamilton.dm.unipi.it/~astdys/mpcobs/numbered/0/1.rwo
% Got to this page via http://hamilton.dm.unipi.it/astdys/index.php?pc=1.1.7.0&n=1
dates = [1989 11 19.151251 ; 1989 12 19.052166 ; 1990 01 04.946184 ; 1990 01 19.896457 ; 1990 02 19.858953];
