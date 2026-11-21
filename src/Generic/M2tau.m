% Input:
%  t - JD epoch
%  M - mean anomaly in degrees for the given JD epoch
%  a - semi-major axis in AU
% Output: JD time of perihelion passage
% Note: equations, tables and pages are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function[tau] = M2tau(t, M, a)
% Constants in SI:
AU = 1.495978707e11; % astronomical unit in m, from table A.1
% Conversion to SI:
a_m = a * AU; % semi-major axis in m
M_rad = M * pi / 180; % mean anomaly in radians for the given JD epoch
% Orbit calculation:
n = 2 * pi / period(a_m); % mean motion in hz, from equation 2.25
n_d = n * 86400; % mean motion in units per day
tau = t - M_rad / n_d; % time of pericentre passage, from equation 2.39
