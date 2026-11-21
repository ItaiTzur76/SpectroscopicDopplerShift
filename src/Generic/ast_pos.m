% Input:
%  a - semi-major axis in AU
%  e - eccentricity
%  omega - longitude of ascending node in radians
%  Pi - argument of perihelion in radians
%  I - inclination in radians
%  tau - time of perihelion passage
%  t_ast - astrometric observation times
% Output: positions relative to the ecliptic plane in m
% Note: equations, tables and pages are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function[X, Y, Z] = ast_pos(a, e, omega, Pi, I, tau, t_ast)
% Constants in SI:
AU = 1.495978707e11; % astronomical unit in m, from table A.1
% Conversion to SI:
a_m = a * AU; % semi-major axis in m
% Orbit calculation:
sinOmega = sin(omega);
cosOmega = cos(omega);
T = period(a_m); % period in s
% Position calculation:
E = kepler_eq(t_ast, T / 86400, tau, e); % eccentric anomalies; Shay Zucker recommended using this function instead of equation 2.51
cosE = cos(E);
r = a_m * (1 - e * cosE); % solar distances in m, from equation 2.42
f = atan2(sqrt(1 - e ^ 2) * sin(E), cosE - e); % true anomalies, from equation 2.41 and the fact that tan(f) = y / x
sinPiF = sin(Pi + f);
cosPiF = cos(Pi + f);
sinPiFCosI = sinPiF * cos(I);
% X, Y, Z positions relative to the ecliptic plane in m, from equation 2.122
X = r .* (cosOmega * cosPiF - sinOmega * sinPiFCosI);
Y = r .* (sinOmega * cosPiF + cosOmega * sinPiFCosI);
Z = r .* sinPiF * sin(I);
