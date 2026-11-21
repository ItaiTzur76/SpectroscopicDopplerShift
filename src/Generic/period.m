% Input: semi-major axis in m
% Output: period in s
% Note: equations, tables and pages are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function T = period(a)
% Msun = 1.98911e30 kg, from table A.1; G = 6.67206e-11 m^3/(kg*s^2), from appendix C of "Worlds Apart"
mu = 6.67206e-11 * 1.98911e30; % in m^3/s^2 from page 24, assuming the orbiting object's mass is negligible compared to the Sun's
T = 2 * pi * sqrt(a ^ 3 / mu); % period in s, from equation 2.22
