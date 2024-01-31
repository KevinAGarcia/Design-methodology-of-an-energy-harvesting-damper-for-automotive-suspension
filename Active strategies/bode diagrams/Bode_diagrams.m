

clc
clear
close all


%vcar = 120/3.6;      % [m/s] vehicle speed
vcar_arra= linspace(35,35,1);
for idxcar = 1:length(vcar_arra)
    disp(string(vcar_arra(idxcar)))
    vcar=vcar_arra(idxcar)/3.6;
%% ISO road profile
Gr = 2.56e-6
wcut =2*pi*vcar/100
% dt = 1e-3; % kiloherstz
% t = 0:dt:10;



%c2_arr = linspace(200,6000,20);
cSky_arr = linspace(0,15000,10);
for idx = 1:length(cSky_arr)
%% State space
k2 = 14070.1;       %[N/m] Suspension stiffness
k1 = 323470;         %[N/m] Tire stiffness
m2 = 247.5;            %[kg]   sprung mass 2
m1 = 38;           %[kg]   unsprung mass 1
c2 = 100;            %[Ns/m] Suspension damping
cSky = cSky_arr(idx);


SS.A = [0 0 1 0 ;
        0 0 0 1 ;
       -((k2/m1)+(k1/m1)) (k2/m1) 0 0;
       (k2/m2) -(k2/m2) 0 0];  
SS.B = [0 0;0 0;(k1/m1) -(1/m1);0 (1/m2)];
SS.C = [1 -1 0 0 ;0 0 -1 1 ;k1 0 0 0;(k2/m2) -(k2/m2) 0 0;0 0 0 1];
SS.D = [0 0;0 0;-k1 0;0 (1/m2);0 0];
%% Run simulation
out = sim('simulink_skyhook_modified2_0');

%% Data analysis
time = out.time;
cond = time>1;
RMS.disp(idx) = rms(out.Disp(cond));
RMS.etarh(idx) = rms(out.Ftire(cond))/(9.81*(m1+m2));
RMS.Vel(idx) = rms(out.Vel(cond));
RMS.acel(idx) = rms(out.acel(cond));

AVG.Fa(idx) = mean(out.Fa(cond));

AVG.Potact(idx) = mean(out.Potact(cond));
Pdamp = c2*out.Vel.^2;
AVG.Pdamp(idx) = mean(Pdamp(cond));
end
%% 
Data.RMS(idxcar)=RMS;
Data.AVG(idxcar)=AVG;
Data.vcar(idxcar)=vcar_arra(idxcar);

 %% Plot


end





%% Plot


b=out.sys
[mag,phase,w]=bode(b.values)
semilogx(squeeze(w),20*log10(squeeze(mag)))
subplot(111)
% semilogx(squeeze(w),20*log10(squeeze(mag)))
% subplot(212)
% semilogx(squeeze(w),squeeze(phase))
hold on
%%



%vcar = 120/3.6;      % [m/s] vehicle speed
vcar_arra= linspace(35,35,1);
for idxcar = 1:length(vcar_arra)
    disp(string(vcar_arra(idxcar)))
    vcar=vcar_arra(idxcar)/3.6;
    %% ISO road profile
    Gr = 2.56e-6
    wcut =2*pi*vcar/100
    % dt = 1e-3; % kiloherstz
    % t = 0:dt:10;
    
    %c2_arr = linspace(200,6000,20);
    cG_arr = linspace(0,1174,10);
    for idx = 1:length(cG_arr)
        %% State space
        k2 = 14070.1;       %[N/m] Suspension stiffness
        k1 = 323470;         %[N/m] Tire stiffness
        m2 = 247.5;            %[kg]   sprung mass 2
        m1 = 38;           %[kg]   unsprung mass 1
        c2 = 100;            %[Ns/m] Suspension damping
        cG = cG_arr(idx);
        
        SS.A = [0 0 1 0 ;
            0 0 0 1 ;
            -((k2/m1)+(k1/m1)) (k2/m1) 0 0;
            (k2/m2) -(k2/m2) 0 0];
        SS.B = [0 0;0 0;(k1/m1) -(1/m1);0 (1/m2)];
        SS.C = [1 -1 0 0 ;0 0 -1 1 ;k1 0 0 0;(k2/m2) -(k2/m2) 0 0;0 0 1 0];
        SS.D = [0 0;0 0;-k1 0;0 (1/m2);0 0];
        %% Run simulation
        out = sim('simulink_groundhook');
        
        %% Data analysis
        time = out.time;
        cond = time>1;
        RMS.disp(idx) = rms(out.Disp(cond));
        
        RMS.etarh(idx) = rms(out.Ftire(cond))/(9.81*(m1+m2));
        RMS.Vel(idx) = rms(out.Vel(cond));
        RMS.acel(idx) = rms(out.acel(cond));
        
        
        AVG.Potact(idx) = mean(out.Potact(cond));
        AVG.Fa(idx) = mean(out.Fa(cond));
        
        Pdamp = c2*out.Vel.^2;
        AVG.Pdamp(idx) = mean(Pdamp(cond));
    end
    %%
    Data.RMS(idxcar)=RMS;
    Data.AVG(idxcar)=AVG;
    Data.vcar(idxcar)=vcar_arra(idxcar);
    
    %% Plot

c=out.ground
[mag,phase,w]=bode(c.values)
semilogx(squeeze(w),20*log10(squeeze(mag)))
subplot(111)
% semilogx(squeeze(w),20*log10(squeeze(mag)))
% subplot(212)
% semilogx(squeeze(w),squeeze(phase))
hold on
%%




qcm_data

%vcar = 120/3.6;      % [m/s] vehicle speed
vcar_arra= linspace(35,35,1);
for idxcar = 1:length(vcar_arra)
    disp(string(vcar_arra(idxcar)))
    vcar=vcar_arra(idxcar)/3.6;
%% ISO road profile
Gr = 2.56e-6
wcut =2*pi*vcar/100



c2_arr = linspace(200,604,10);
for idx = 1:length(c2_arr)
%% State space
k2 = 14070.1;       %[N/m] Suspension stiffness
k1 = 323470;         %[N/m] Tire stiffness
m2 = 247.5;            %[kg]   sprung mass 2
m1 = 38;           %[kg]   unsprung mass 1
c2 = c2_arr(idx);

SS.A = [0 0 1 0 ;
        0 0 0 1 ;
       -((k2/m1)+(k1/m1)) (k2/m1) -(c2/m1) (c2/m1);
       (k2/m2) -(k2/m2) (c2/m2) -(c2/m2)];  
SS.B = [0; 0 ;k1/m1; 0];
SS.C = [1 -1 0 0 ;0 0 -1 1 ;k1 0 0 0;(k2/m2) -(k2/m2) (c2/m2) -(c2/m2) ];
SS.D = [0;0;-k1;0];
%% Run simulation
out = sim('simulinkcorregidoquartercar2');

%% Data analysis
time = out.time;
cond = time>1;
RMS.disp(idx) = rms(out.Disp(cond));
RMS.etarh(idx) = rms(out.Ftire(cond))/(9.81*(m1+m2));
RMS.Vel(idx) = rms(out.Vel(cond));
RMS.acel(idx) = rms(out.acel(cond));
Pdamp = c2*out.Vel.^2;
AVG.Pdamp(idx) = mean(Pdamp(cond));
end
%% 
Data.RMS(idxcar)=RMS;
Data.AVG(idxcar)=AVG;
Data.vcar(idxcar)=vcar_arra(idxcar);


end


%% Plot



d=out.passive
[mag,phase,w]=bode(d.values)
semilogx(squeeze(w),20*log10(squeeze(mag)))
subplot(111)

hold off