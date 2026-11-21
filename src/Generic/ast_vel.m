% Input:
%  a - semi-major axis in AU
%  e - eccentricity
%  omega - longitude of ascending node in radians
%  Pi - argument of perihelion in radians
%  I - inclination in radians
%  tau - time of perihelion passage
%  t_dop - Doppler observation times
% Output: velocities relative to the ecliptic plane in m/s
% Note: equations, tables and pages are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function[dX_dt, dY_dt, dZ_dt, dr_dt] = ast_vel(a, e, omega, Pi, I, tau, t_dop)
% Constants in SI:
AU = 1.495978707e11; % astronomical unit in m, from table A.1
% Conversion to SI:
a_m = a * AU; % semi-major axis in m
% Orbit calculation:
sinOmega = sin(omega);
cosOmega = cos(omega);
cosI = cos(I);

T = period(a_m); % period in s
n = 2 * pi / T; % mean motion in hz, from equation 2.25
% Position calculation:
E = kepler_eq(t_dop, T / 86400, tau, e); % eccentric anomalies; Shay Zucker recommended using this function instead of equation 2.51
f = atan2(sqrt(1 - e ^ 2) * sin(E), cos(E) - e); % true anomalies, from equation 2.41 and the fact that tan(f) = y / x

coef = n * a_m / sqrt(1 - e ^ 2); % change rate coefficient in m/s
dr_dt = coef * e * sin(f); % solar distance change rates in m/s, from equation 2.31
rdf_dt = coef * (1 + e * cos(f)); % true anomaly change rates times solar distances, in m/s, from equation 2.32

sinPiF = sin(Pi + f);
cosPiF = cos(Pi + f);
sinPiFCosI = sinPiF * cosI;
cosPiFCosI = cosPiF * cosI;
% X, Y, Z velocities relative to the ecliptic plane in m/s, from derivative of equation 2.122
dX_dt = dr_dt .* (cosOmega * cosPiF - sinOmega * sinPiFCosI) - rdf_dt .* (cosOmega * sinPiF + sinOmega * cosPiFCosI);
dY_dt = dr_dt .* (sinOmega * cosPiF + cosOmega * sinPiFCosI) + rdf_dt .* (cosOmega * cosPiFCosI - sinOmega * sinPiF);
dZ_dt = (dr_dt .* sinPiF + rdf_dt .* cosPiF) * sin(I);
