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
![image](https://github.com/KevinAGarcia/Design-methodology-of-an-energy-harvesting-damper-for-automotive-suspension/assets/113644566/40cfa635-a57a-41fd-b70b-690d60898986)


Simulations
Simulations are performed in Simulink where c_2 is varying and the road condition was synthetized as Road class C (average) For the three performance indexes.

