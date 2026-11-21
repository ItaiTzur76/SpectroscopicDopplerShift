% Plot the observed track of a given object during its tests
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
dateStrings = num2str(fliplr(floor(dates)), '.%02d');
t_ast5 = juliandate([dates(1,:) ; dates(2,:) ; dates(3,:) ; dates(4,:) ; dates(5,:)]);
[ra, dec, dop] = ast_orb(orb_el, t_ast5, t_ast5);

plot([ra(1) ; ra(2) ; ra(4) ; ra(5)], [dec(1) ; dec(2) ; dec(4) ; dec(5)], '*b', ra(3), dec(3), '*r')
ax = axis;
x = [];
y = [];

t = t_ast5(1);
ra1 = ra(1);
dec1 = dec(1);
while ra1 >= ax(1) && ra1 <= ax(2) && dec1 >= ax(3) && dec1 <= ax(4)
	x = [ra1 ; x];
	y = [dec1 ; y];
	t = t - 1;
	[ra1, dec1] = ast_orb(orb_el, t, []);
end
t = t_ast5(1) + 1;
[ra1, dec1] = ast_orb(orb_el, t, []);
while t < t_ast5(5) || (ra1 >= ax(1) && ra1 <= ax(2) || dec1 >= ax(3) && dec1 <= ax(4))
	x = [x ; ra1];
	y = [y ; dec1];
	t = t + 1;
	[ra1, dec1] = ast_orb(orb_el, t, []);
end

plot(x, y, [ra(1) ; ra(2) ; ra(4) ; ra(5)], [dec(1) ; dec(2) ; dec(4) ; dec(5)], '*b', ra(3), dec(3), '*r')
axis(ax)
title([name, ' Astrometric Orbit'])
xlabel('Right Ascension (degrees)')
ylabel('Declination (degrees)')
for i = 1 : size(t_ast5, 1)
	text(ra(i), dec(i), [' ', num2str(i)])
end
text(ax(1), ax(3), [repmat(' ', size(t_ast5, 1), 1), num2str((1 : size(t_ast5, 1))', '%d: '), dateStrings(:, 2 : end)], 'VerticalAlignment', 'Bottom')

figure
plot([t_ast5(1) ; t_ast5(2) ; t_ast5(4) ; t_ast5(5)] - 2400000.5, [dop(1) ; dop(2) ; dop(4) ; dop(5)], '*b', t_ast5(3) - 2400000.5, dop(3), '*r')
ax = axis;
x = [];
y = [];
t = t_ast5(1);
dop1 = dop(1);
while t - 2400000.5 >= ax(1) && t - 2400000.5 <= ax(2) && dop1 >= ax(3) && dop1 <= ax(4)
	x = [t ; x];
	y = [dop1 ; y];
	t = t - 1;
	[ra1, dec1, dop1] = ast_orb(orb_el, [], t);
end
t = t_ast5(1) + 1;
[ra1, dec1, dop1] = ast_orb(orb_el, [], t);
while t < t_ast5(5) || (t - 2400000.5 >= ax(1) && t - 2400000.5 <= ax(2) || dop1 >= ax(3) && dop1 <= ax(4))
	x = [x ; t];
	y = [y ; dop1];
	t = t + 1;
	[ra1, dec1, dop1] = ast_orb(orb_el, [], t);
end
plot(x - 2400000.5, y, [t_ast5(1) ; t_ast5(2) ; t_ast5(4) ; t_ast5(5)] - 2400000.5, [dop(1) ; dop(2) ; dop(4) ; dop(5)], '*b', t_ast5(3) - 2400000.5, dop(3), '*r')
axis(ax)
title([name, ' Doppler Trace'])
xlabel('Time (MJD)')
ylabel('Radial Velocity (km/s)')
for i = 1 : size(t_ast5, 1)
	text(t_ast5(i) - 2400000.5, dop(i), [' ', num2str(i)])
end
text(ax(1), ax(3), [repmat(' ', size(t_ast5, 1), 1), num2str((1 : size(t_ast5, 1))', '%d: '), dateStrings(:, 2 : end)], 'VerticalAlignment', 'Bottom')
