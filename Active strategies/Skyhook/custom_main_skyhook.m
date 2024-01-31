
clc
clear
close all



%vcar = 120/3.6;      % [m/s] vehicle speed
vcar_arra= linspace(10,100,20);
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
cSky = cSky_arr(idx)


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
  subplot(3,1,1)
    text = "";
    plot(cSky_arr,Data.AVG(idxcar).Potact,'displayname',num2str(vcar_arra(idxcar)));
    hold on
    lg = legend('location','eastoutside');
    lg.Title.String = 'Velocity [km/h]';
    title("Road class C",'FontSize',20);
    xlabel("cSkyhook [Ns/m]")
    ylabel("Avg Power [W]")
    
    subplot(3,1,2)
    text = "";
    plot(cSky_arr,Data.RMS(idxcar).etarh,'displayname',num2str(vcar_arra(idxcar)));
    hold on
    lg = legend('location','eastoutside');
    lg.Title.String = 'Velocity [km/h]';
    xlabel("cSkyhook [Ns/m]")
    ylabel("Road handling")
    
    subplot(3,1,3)
    text = "";
    plot(cSky_arr,Data.RMS(idxcar).acel,'displayname',num2str(vcar_arra(idxcar)));
    hold on
    lg = legend('location','eastoutside');
    lg.Title.String = 'Velocity [km/h]';
    xlabel("cSkyhook [Ns/m]")
    ylabel("Weighted acceleration [m/s^2]")


end

%PavgZuo = pi*vcar*Phi0*(1/Om0)^(-w)*k1/2



%% Plot

% subplot(3,1,1)
% text = "";
% for i= 1:length(Data.AVG)
% plot(cSky_arr,Data.AVG(i).Potact)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% title("Road class C",'FontSize',20);
% xlabel("CSkyhook")
% ylabel("Avg Power [W]")
% 
% subplot(3,1,2)
% text = "";
% for i= 1:length(Data.RMS)
% plot(cSky_arr,Data.RMS(i).etarh)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% xlabel("CSkyhook")
% ylabel("Road handling")
% 
% subplot(3,1,3)
% text = "";
% for i = 1:length(Data.RMS)
% plot(cSky_arr,Data.RMS(i).acel)
% text(i) = string(vcar_arra(i));
% hold on
% end
% hold off
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% xlabel("CSkyhook")
% ylabel("Weighted acceleration [m / s^2]")

% subplot(1,1,1)
% text = "";
% for i = 1:length(Data.RMS)
% plot(out.Vel,-out.Fa,".","color",[0.25, 0.25, 0.25])
% text(i) = string(vcar_arra(i));
% hold on
% end
% plot(zeros(1,2),[-1000,1000])
% plot([-1.5,1],zeros(1,2))
% yline(0,"color",[0, 0.4470, 0.7410])
% xline(0,"color",[0, 0.4470, 0.7410])
% hold off
% Damp_perc=sum((out.Vel>0 & -out.Fa>0)|(out.Vel<0 & -out.Fa<0))/length(out.Fa)*100;
% Actu_perc=sum((out.Vel<0 & -out.Fa>0)|(out.Vel>0 & -out.Fa<0))/length(out.Fa)*100;
% lg = legend(text(1:end),'location','eastoutside');
% lg.Title.String = 'Velocity [km/h]';
% xlabel("Damping Velocity [m/s]")
% ylabel("Damping Force [N] ")
% 
% textbox = "Damper = " + string(Damp_perc)+"%" + newline + "Actuation = "+ string(Actu_perc)+"%";
% annotation('textbox',[0.95,0.12,0,0],'String',textbox,'FitBoxToText','on', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
% 
% 
% wfig =11;
% hfig = 8;
% img_res = '-r400';
% set(gcf, 'renderer', 'painters');
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [wfig hfig]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 wfig hfig]);
% 
% print(gcf, '-dpng', img_res, 'figg');

