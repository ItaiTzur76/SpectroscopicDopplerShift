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
% Output:
%  ra (n1*1) - right-ascensions in degrees
%  dec (n1*1) - declinations in degrees
%  decop (n2*1) - Doppler shifts in km/s
function[ra, dec, dop] = ast_orb(orb_el, t_ast, t_dop)
% Constants in SI:
degrees = pi / 180; % number of radians per degree
% Input conversion
a = orb_el(1);
e = orb_el(2);
omegaRad = orb_el(3) * degrees; % longitude of ascending node in radians
PiRad = orb_el(4) * degrees; % argument of perihelion in radians
IRad = orb_el(5) * degrees; % inclination in radians
tau = orb_el(6);
[aE, eE, omegaE, PiE, IE, tauE] = earth_orb;
omegaERad = omegaE * degrees; % longitude of ascending node in radians
PiERad = PiE * degrees; % argument of perihelion in radians
IERad = IE * degrees; % inclination in radians
% Position calculations:
[Xobj, Yobj, Zobj] = ast_pos(a, e, omegaRad, PiRad, IRad, tau, t_ast);
[XE, YE, ZE] = ast_pos(aE, eE, omegaERad, PiERad, IERad, tauE, t_ast);
X = Xobj - XE;
Y = Yobj - YE;
Z = Zobj - ZE;
epsilon = (23 + 26 / 60) * degrees; % obliquity of the ecliptic (angle between the equatorial and ecliptic planes)
sinEpsilon = sin(epsilon);
cosEpsilon = cos(epsilon);
beta = atan2(Z, sqrt(X .^ 2 + Y .^ 2)); % ecliptic latitudes (angular distances from the ecliptic, in the range [-90,+90] degrees)
lambda = atan2(Y, X); % ecliptic longitudes (measured counterclockwise from the vernal equinox)

sinBeta = sin(beta);
cosBeta = cos(beta);
sinLambda = sin(lambda);
% Transformation from the ecliptic to the equatorial frame, according to equation 2.23 in
% http://springerlink.metapress.com/content/l206t5wg0100j4m6/?p=defc6ba001724d6babf072806541a64a&pi=39
dec = asin(sinBeta * cosEpsilon + cosBeta * sinEpsilon .* sinLambda);
cosDec = cos(dec);
dec = dec / degrees; % conversion from radians to degrees
sinRA = (-sinBeta * sinEpsilon + cosBeta * cosEpsilon .* sinLambda) ./ cosDec;
cosRA = cos(lambda) .* cosBeta ./ cosDec;
ra = atan2(sinRA, cosRA);
ra = ra / degrees; % conversion from radians to degrees
% Velocity calculations:
[Xobj, Yobj, Zobj] = ast_pos(a, e, omegaRad, PiRad, IRad, tau, t_dop);
[XE, YE, ZE] = ast_pos(aE, eE, omegaERad, PiERad, IERad, tauE, t_dop);
X = Xobj - XE;
Y = Yobj - YE;
Z = Zobj - ZE;
[dXobj_dt, dYobj_dt, dZobj_dt, dr_dt] = ast_vel(a, e, omegaRad, PiRad, IRad, tau, t_dop);
[dXE_dt, dYE_dt, dZE_dt] = ast_vel(aE, eE, omegaERad, PiERad, IERad, tauE, t_dop);
% The distance between the object and Earth is sqrt(X .^ 2 + Y .^ 2 + Z .^ 2) and so its change rate is:
drObjE_dt = (X .* (dXobj_dt - dXE_dt) + Y .* (dYobj_dt - dYE_dt) + Z .* (dZobj_dt - dZE_dt)) ./ sqrt(X .^ 2 + Y .^ 2 + Z .^ 2);
dop = (dr_dt + drObjE_dt) / 1000; % Doppler shift, in km/s
