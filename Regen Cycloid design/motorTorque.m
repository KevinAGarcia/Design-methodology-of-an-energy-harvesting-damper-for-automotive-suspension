function [OUT] = motorTorque(L,Rso,Rro_min)
% [m] active length
% [m] stator outside radius 
% [m] rotor outside radius (minimum)


%% Input parameters
JwRms = 20e6;                 % [A/m^2] wire current density
Nm = 10;                     % [-] number of magnets
Ns = 12;                     % [-] number of slots               

%% Fixed design parameters
Nph = 3;                    % [-] number of phases
g = 0.5e-3;                 % [m] air gap length
kst = 0.95;                 % [-] lamination stacking factor
kcp = 0.2835;               % [-] coil packing factor
alpham = 0.9;               % [-] magnet fraction
ws = 2e-3;                  % [m] slot opening
alphasd = 0.25;             % [-] shoe depth fraction
Pc = 5;                     % [-] permeance coefficient

%% Material parameters
Br = 1.25;                  % [T] magnet remanence
muR = 1.05;                 % [-] magnet relative permeability
mu0 = 4*pi*1e-7;            % [H/m] vacuum permeability
Bmax = 1.2;                 % [T] iron saturation

%% Rotor radius
% Rro_arr = linspace(Rro_min,0.8*Rso,1e3);
Rro_arr = 0.6*Rso;
for idx = 1:length(Rro_arr)
    Rro = Rro_arr(idx)
    
    %% Derived parameters
    Nsm = Ns/Nm;                  % number of slots per magnet
    Nsp = Ns/Nph;                 % number of slots per phase
    Nspp= Ns/Nm/Nph;              % number of slots per pole per phase
    thetap = 2*pi/Nm;             % angular pole pitch
    thetas = 2*pi/Ns;             % angular slot pitch
    thetase= pi/Nsm;              % electrical slot pitch
    kp = max(floor(Nspp)/Nspp,1); % pitch factor
    Rsi = Rro+g                  % stator inside radius
    taup = Rsi*thetap;            % pole pitch
    taus = Rsi*thetas;            % slot pitch
    wt = taus-ws;                 % tooth width
    kd = sin(Nspp*thetase/2) ...  % distribution factor
        /(Nspp*sin(thetase/2));
    
    %% Geometry
    ks = 1;                     % Skew factor (no skewing)
    Cphi = 2*alpham/(1+alpham); % Flux concentration factor
    lm = Pc*(g*Cphi);           % Magnet length
    kml = 1+4*lm/(pi*muR*...    % Magnet leakage factor
        alpham*taup)*log(1+...
        pi*g/((1-alpham)*taup));
    kc = 1/(1-ws/taus+...       % Carter coefficient
        4*g/pi/taus*log(...
        1+pi*ws/4/g));
    Ag = taup*L*(1+alpham)/2   % Air gap mean cross section
    Bg = Cphi*Br/...            % Air gap flux density
        (1+(muR*kc*kml/Pc));
    phig = Bg*Ag;               % Air gap flux
    wbi = phig/(2*Bmax*kst*L);  % Back iron width
    wtb = 2/Nsm*wbi;            % Tooth base width
    Rsb = Rso-wbi              % Stator base radius
    Rri = Rro-lm-wbi;           % Rotor inside radius
    wsb = Rsb*thetas-wtb;       % Slot bottom width
    wsi = (Rsi+alphasd*wtb)*... % Slot width beyond the shoes
        thetas-wtb;
    alphas = wsi/(wsi+wtb);     % Slot fraction
    ds = Rsb-Rro-g;             % Tooth length
    d3 = ds-alphasd*wtb;        % Tooth base length
    d1d2 = alphasd*wtb;         % Shoe length
    As = d3*(thetas*...         % Slot cross section
        (Rsb-d3/2)-wtb);
    
   
    
    k(idx)=(3/2)*Nm*kd*kp*ks*Bg*kst*Nspp*JwRms*sqrt(2)*kcp*As*Rro;
    if ds < 0.002
        k(idx) =0
    end
    T(idx) = (3/2)*Nm*kd*kp*ks*Bg*L*kst*Rro*Nspp*JwRms*sqrt(2)*kcp*As;
end
OUT.K = max(k);
OUT.RromaxK = Rro_arr(k==OUT.K);
OUT.T = max(T)
OUT.Rro = Rro_arr(T==OUT.T);
rho = 8000;
OUT.m_mot = Rso^2*pi*L*rho;
OUT.m_rot = OUT.Rro^2*pi*L*rho;
OUT.J_mot = OUT.m_rot*OUT.Rro^2/2;