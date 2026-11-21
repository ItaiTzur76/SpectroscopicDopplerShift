% Output: Earth's orbital elements, from table A.2:
%  a - semi-major axis in AU
%  e - eccentricity
%  omega - longitude of ascending node in degrees
%  Pi - argument of perihelion in degrees
%  I - inclination in degrees
%  tau - time of perihelion passage
%  T - period in s
%  AU - astronomical unit in m
% Note: equations and tables are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function[a, e, omega, Pi, I, tau, T, AU] = earth_orb
AU = 1.495978707e11; % astronomical unit in m, from table A.1
a = 1.00000011; % AU
e = 0.01671022;
I = 0.00005;
Pi = 102.94719;
omega = 348.73936;
T = period(a * AU); % period in s
tEph = 2451545; % ephemeris time, from step 1 of section 8.10.1 in http://iau-comm4.jpl.nasa.gov/keplerformulae/kepform.pdf
lambda = 100.46457166; % mean longitude at tEph, from http://ssd.jpl.nasa.gov/txt/p_elem_t1.txt
curlyPi = 102.93768193; % longitude of pericentre, from http://ssd.jpl.nasa.gov/txt/p_elem_t1.txt
M = lambda - curlyPi; % mean anomaly at tEph, from equation 2.53
tau = M2tau(tEph, M, a);
