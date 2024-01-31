
%% 
   
    Fmax         =  2000;  %[N]
    Vel          =  2;      %[m/s]
    Tau_lever    =  0.2913; %[m/rad]
    Ang_VelIn    =  Vel /Tau_lever;

    %%Gear box

    TorqGearbox  = Fmax*Tau_lever
%% Electic motor constants
    
    L=1;
    Rro_min=0.01;

    
 %%  
     i=1
     Zb=14
     Array_Zb=[]
     Array_vol=[]
while true
    Zb=Zb+1
    
    Zg=Zb-1
    
    Tau_Gearbox  = (1/Zg)^2;

    ang_velMotor = Ang_VelIn*(60/(2*pi))/Tau_Gearbox;
    
    TorqMotor    = TorqGearbox*Tau_Gearbox;
        %% Suspension
    
        if ang_velMotor < 15000;
           
            [xopt,TorqMotor,Volcycloidal]=main_opCycloid(Zb,Zg,TorqMotor);
            
            Rso = xopt(1)/2
            OUT=motorTorque(L,Rso,Rro_min)
           
            
            k=OUT.K

            L=TorqMotor/k
            TorqMotor
            % Volumen total
            Volmotor=pi*(Rso)^2*L

            Voltotal =Volcycloidal + Volmotor
            
            Array_Zb(i)=Zb;
            Array_vol(i)=Voltotal;
            i=i+1;
            
        else 
            break 
        end  
            
end           
 Array_Zb
 Array_vol
plot( Array_Zb, Array_vol), 
legend('Zb vs Vol')
xlabel('Zb'), ylabel('Vol')
title('Zb vs Vol')






