clc
clear
close all

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
k2 = 20053;
k1 = 182087;
m2 = 362.7;
m1 = 40;
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

% subplot(3,1,1)
% text = "";
% for i= 1:length(Data.AVG)
% plot(c2_arr,Data.AVG(i).Pdamp)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% title("Road class B",'FontSize',20);
% xlabel("Damping coefficient")
% ylabel("Avg Power")
% 
% subplot(3,1,2)
% text = "";
% for i= 1:length(Data.RMS)
% plot(c2_arr,Data.RMS(i).etarh)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% xlabel("Damping coefficient")
% ylabel("Road handling ")
% 
% subplot(3,1,3)
% text = "";
% for i = 1:length(Data.RMS)
% plot(c2_arr,Data.RMS(i).acel)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% xlabel("Damping coefficient")
% ylabel("weighted acceleration")
% 
% wfig = 5;
% hfig = 4;
% img_res = '-r400';
% set(gcf, 'renderer', 'painters');
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [wfig hfig]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 wfig hfig]);
% print(gcf, '-dpng', img_res, 'fig');

d=out.passive
[mag,phase,w]=bode(d.values)
semilogx(squeeze(w),20*log10(squeeze(mag)))
subplot(111)