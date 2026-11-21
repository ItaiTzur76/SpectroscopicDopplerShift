function[E] = kepler_eq(t,P,T,ecc)
%
% Solve iteratively the Kepler equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

M = mod((t-T)/P,1)*2*pi;
E = M;
deltaE = 0.;

stop = 0;
EPS = 1e-9;

while ~stop
    E = E+deltaE;
    es = ecc*sin(E);
    EesM = E - es - M;
    ec1 = 1 - ecc*cos(E);
    deltaE = -EesM.*ec1./(ec1.^2-0.5*EesM.*es);
    stop = prod(double(abs(deltaE) < EPS));
end