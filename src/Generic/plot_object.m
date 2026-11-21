% Plot the locations of a given object during its tests
% Input: parameters describing the desired object:
%  name - object's name
%  orb_el - the object's orbital elements, consisting of the following:
%   orb_el(1) - semi-major axis in AU
%   orb_el(2) - eccentricity
%   orb_el(3) - longitude of ascending node in degrees
%   orb_el(4) - argument of perihelion in degrees
%   orb_el(5) - inclination in degrees
%   orb_el(6) - time of perihelion passage
%  dates - a matrix where each row is an observation date to be plotted
% Note: equations, tables and pages are from "Solar System Dynamics" by Murray and Dermott, unless stated otherwise
function plot_object(name, orb_el, dates)
degrees = pi / 180; % number of radians per degree
a = orb_el(1);
e = orb_el(2);
omegaRad = orb_el(3) * degrees; % longitude of ascending node in radians
PiRad = orb_el(4) * degrees; % argument of perihelion in radians
IRad = orb_el(5) * degrees; % inclination in radians
tau = orb_el(6);
[aE, eE, omegaE, PiE, IE, tauE, TE, AU] = earth_orb;
omegaERad = omegaE * degrees; % longitude of ascending node in radians
PiERad = PiE * degrees; % argument of perihelion in radians
IERad = IE * degrees; % inclination in radians
[X Y] = ast_pos(a, e, omegaRad, PiRad, IRad, tau, juliandate(dates));
X = X / AU;
Y = Y / AU;
[Xp Yp] = ast_pos(a, e, omegaRad, PiRad, IRad, tau, tau);
Xp = Xp / AU;
Yp = Yp / AU;
[Xorb Yorb] = ast_pos(a, e, omegaRad, PiRad, IRad, tau, linspace(0, period(a * AU) / 86400, 360));
Xorb = Xorb / AU;
Yorb = Yorb / AU;
[XE YE] = ast_pos(aE, eE, omegaERad, PiERad, IERad, tauE, juliandate(dates));
XE = XE / AU;
YE = YE / AU;
[XEorb YEorb] = ast_pos(aE, eE, omegaERad, PiERad, IERad, tauE, linspace(0, TE / 86400, 360));
XEorb = XEorb / AU;
YEorb = YEorb / AU;
plot(Xorb, Yorb, XEorb, YEorb, 0, 0, X, Y, '*', XE, YE, '+', 0, 0, 'O', Xp, Yp, 'X')
for i = 1 : size(X, 1)
	text(X(i), Y(i), [' ', num2str(i)])
	text(XE(i), YE(i), [' ', num2str(i)])
end
axis([min([Xorb XEorb]) max([Xorb XEorb]) min([Yorb YEorb]) max([Yorb YEorb])])
dateStrings = num2str(fliplr(floor(dates)), '.%02d');
text(min([Xorb XEorb]), min([Yorb YEorb]), [repmat(' ', size(X, 1), 1), num2str((1 : size(X, 1))', '%d: '), dateStrings(:, 2 : end)], 'VerticalAlignment', 'Bottom')
text(Xp, Yp, ' Perihelion')
title([name, ' Observations'])
xlabel('AU')
ylabel('AU')
legend(name, 'Earth')
