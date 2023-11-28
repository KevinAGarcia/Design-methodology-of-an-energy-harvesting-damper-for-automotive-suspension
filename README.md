# Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension



Project description 


Energy losses in automobile cars nowadays are significant. To improve fuel economy in cars, reduce Co2 emissions and supply other power demand systems, recovery systems were developed such as the regenerative braking energy and others are gaining attention like vibration energy recovery on shock absorbers. Therefore, this energy dissipated through the shock absorber as heat can be transformed into electricity and stored in a battery for other use in the vehicle. 



The main contribution of this research project is :
1. The implementation of a Cycloid Drive which was never used for this type of application and is totally new in the state of the art.
2. The optimization design methodology to couple both components together, the Electric Motor model and the Cycloid Drive model. A way to link them is presented, and several tests are performed with the parameters of the EV-TEC.


Ev tec

An electric vehicle developed by students and professors from Tec de Monterrey.
For this project, the parameters of this vehicle are used, and the regenerative elements are going to be tested in the rear end of the suspension.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/93510b3a-d6c7-4bee-a0d0-e4834dd041e2)



First step
Vehicle Modeling

Quarter car

The EV-TEC is modeled in a quarter car of 2 DOF with its original passive suspension. A sprung mass M_2, a Tire represented with M_1 and K_1 and the suspension represented by a spring K_2 and damper C_2.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/d7230f71-b917-4897-be0e-2e1cbe3bb201)


Performance indexes and road profile

A quarter car is used to obtain the State space matrix to model the vehicle. The road modeling is created to represent road profiles. The four outputs are used to obtain three performance indexes: Avg Power, Road Handling, and Weighted acceleration.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/bf35b93e-d5b6-49d9-9066-24a78b19adc3)



Simulations

Simulations are performed in Simulink where c_2 is varying and the road condition was synthetized as Road class C (average) For the three performance indexes.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/6827501c-a25a-46b8-aff3-701112ae2829)


Second step
Active strategies

Reason for using active strategies
Active suspensions have a quicker response of milliseconds and if they are regenerative active suspensions, they have a demand in energy that is lower than a regular fully active which makes them more attractive than other types of suspension systems. 
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/930f9427-e10f-4930-a9ad-0f99d4b26139)


Quarter car with actuator
The quarter car has an actuator Fa, and this actuator works with 2 equations; Groundhook for better handling 𝑐_𝑔 and  and Skyhook for comfort 𝑐_𝑠𝑘𝑦.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/2245e6aa-9459-4c1c-a65d-7c2f51d06b10)


Simulations
The comparative chart demonstrates the values while varying the 𝑐_𝑠𝑘𝑦,𝑐_𝑔 for the three performance indexes; Average Power, Road handling, and Weighted acceleration.
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/cd55fff3-f7e5-4577-8665-3d6dc58bdc01)


