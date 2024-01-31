function yout = fnOpt(x,PAR)
Dz = x(1);                  % [m] diameter of the pin gear distributed circle
dzp = x(2);                 % [m] diameter of pin
B = x(3);                   % [m] width of cycloid gear
K1 = x(4);                  % [-] short width coefficient
dw = x(5);                  % [m] diameter of cylindrical pin

% Volume [m^3]
delta = PAR.b-B;
y(1) = pi/4*(Dz+dzp+2*PAR.Delta1)^2*(2*B+delta);

% Radial load on turning arm bearing [N]
Tg = 0.55*PAR.Tv;
y(2) = 2.6*Tg*PAR.Zb/(K1*Dz*PAR.Zg);

% Maximum bending stress of the pin [Pa]
L1 = 0.5*B + PAR.deltap + 0.5*PAR.Delta;
L2 = 1.5*B + PAR.deltap + delta + 0.5*PAR.Delta;
L = L1 + L2;
y(3) = (44*L1*L2*PAR.Tv)/(L*K1*PAR.Zg*Dz*dzp^3);

%% Constraints
g(1) = 0.45 - K1;
g(2) = K1 - 0.8;

alphamin = (1+K1)^2/(1+K1+PAR.Zg*K1);

g(3) = (dzp+2*PAR.Delta1)/Dz - alphamin;

T = 0.03*Dz;
Rz = Dz/2;
e = K1*Rz/PAR.Zb;
dsk = dw + 2*e;
dfc = Dz-4*e;
Dw = (dfc + PAR.D1)/2;


g(4) = 2*T-Dw+dsk+PAR.D1;

g(5) = T - Dw*sin(pi/PAR.Zw) + dsk;

K2 = (Dz/(dzp+2*PAR.Delta1))*sin(pi/PAR.Zb);

g(6) = 1.25-K2;

g(7) = K2-4;

rw = dw/2+PAR.Delta2;
th = linspace(0,90,1e3);
Fi = 2.2*PAR.Tv*sind(th)./(K1*PAR.Zg*Rz*sqrt(1+K1^2-2*K1*cosd(th)));
rho = (1+K1^2-2*K1*cosd(th)).^1.5*Rz./(K1*(1+PAR.Zb)*cosd(th)-(1+PAR.Zb*K1^2)) + rw;
rhod = 1./(1./rho + 1/rw);

sigmaHP = 0.418*sqrt(Fi*PAR.Ed./(B*rhod));
istop = find(imag(sigmaHP)>0,1,'first');
if isempty(istop)
    g(8) = 1;
else
    g(8) = max(sigmaHP(1:istop))-PAR.sigmaHP;
end

delta = PAR.b-B;
L1 = 0.5*B + PAR.deltap + 0.5*PAR.Delta;
L2 = 1.5*B + PAR.deltap + delta + 0.5*PAR.Delta;
L = L1 + L2;

g(9) = 44*L1*L2*PAR.Tv/(L*K1*PAR.Zg*Dz*dzp^3)-PAR.sigmaFP;

rw = dw/2+PAR.Delta2;

g(10) = 0.0949*sqrt(10*K1*PAR.Tv*Dz/(PAR.Zw*Dw*B*(rw^2*PAR.Zb+Dz*K1/2*rw)))-PAR.sigmaHP;

g(11) = 96/pi*PAR.Tv*(1.5*B+delta)/(PAR.Zw*Rz*dw^3)-PAR.sigmaFP;  % Safety factor 3

Tg = 0.55*PAR.Tv;
R = 2.6*Tg*PAR.Zb/(K1*Dz*PAR.Zg);

g(12) = PAR.Lh - ((1e6)/(60*PAR.n))*(PAR.C/(1.2*R))^(10/3);

yout = y(1)+sum(g>0);

end

 