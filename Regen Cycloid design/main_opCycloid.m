
function [xopt,TorqMotor,yopt,Zg ]  = main_opCycloid(Zb,Zg,TorqMotor)

% clc
% clear
% close all
% 
PAR.Zb=Zb
PAR.Zg=Zg

%% Objective Functions

PAR.Delta = 0.0022;           % [m] thickness of the side wall of the pin gear housing
PAR.Delta1 = 0.0030;            % [m] thickness of pin sleeve
PAR.b = 0.010;                % [m] width of the turning arm bearing
% PAR.Zb = 30;                  % [-] number of teeth of the pin gears
% PAR.Zg = PAR.Zb-1;            % [-] number of cycloid gear teeth
PAR.Tv = TorqMotor                      % [Nm] output torque
PAR.deltap = 0.0079;          % [m] distance between cycloid gear and side wall

%% Fixed design parameters
PAR.Pin = 4000;

% PAR.ratio = 29;
PAR.sigmaHP = 850e6;        % [Pa] contact stress
PAR.Zw = 10;                % [-] number of cylindrical pins
PAR.D1 =0.0568;           % [m] external diameter of turning arm bearing
PAR.Ed = 210e9;            % [Pa] equivalent elastic modulus between pin and cycloid gears
PAR.Lh = 5000;              % [h] bearing life
PAR.C = 64900;              % [N] rated dynamic load of the turning arm bearing
PAR.sigmaFP = 150e6;        % [Pa] bending stress

%% Unknown variables
PAR.Delta2 = 0.0030;          % [m] thickness of cylindrical pin sleeve
PAR.n = 1440;                % [rpm] rotating speed of the bearing

%% Constraints conditions

x0(1) = 100e-3;             % Dz
x0(2) = 9e-3;              % dz
x0(3) = 10e-3;              % B
x0(4) = 0.5;               % K1
x0(5) = 20e-3;              % dw


lb = [80e-3,6e-3,4e-3,0.4,3e-3];
ub = [300e-3,12e-3,17e-3,0.8,55e-3];

options = optimoptions('particleswarm');
options.Display = 'iter';
options.UseParallel = true;
options.FunctionTolerance = 1e-6;
options.SwarmSize = 200;
options.MaxStallIterations = 100;
[xopt,yopt,exitFlag,Output] = particleswarm(@(x)fnOpt(x,PAR),...
    length(lb),lb,ub,options)


fnNLCon(xopt,PAR)
%
% options = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotdistance});
%
% options.MaxGenerations = 600;
% options.PopulationSize = 300;
% options.Display = 'iter';
% options.FunctionTolerance = 1e-7;
% options.UseParallel = true;
% FitnessLimit =inf
% MaxStallGenerations =100
%
% [x,fval,exitFlag,Output] = ga(@(x)fnOpt(x,PAR),length(lb),[],[],[],[],lb,ub,@(x)fnNLCon(x,PAR),options);

end
%
% fnOpt([240e-3,10e-3,17e-3,0.75,20e-3],PAR)
