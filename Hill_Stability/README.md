# 30 Arietis Hill Stability
The objective of this program is to determine if the system is stable and calculate the Hill radius of the components of the system. The system is arranged by two close, binary components with a third distant component. The explaination and equations for this program are derived from Boyle et al. (2021) paper[^1] 

For the purposes of this research, the values used are for the system 30 Arietis, however the source code can be referenced to assess Hill stability of other 3 body systems. 

### Contact
Blake Wittmayer & Manfred Cuntz  
Univerisity of Texas at Arlington  
blake.wittmayer@mavs.uta.edu  
cuntz@uta.edu  

## Description of values 
The following values are inputted into the program. 
- **m1, m2, m3**:  Masses of the 3 different components, with m1 and m2 being close companions and m3 being a distant companion. It is assumed that m1 is significantly greater than the other two bodies. Units are in values of solar masses.
- **a1, a2**: Semi-major axes of m2 and m3 respectively. Units are in values of astronomical units (au). 

The following values are used for calcualations and output data 
- **M**:  Sum of the masses m1 and m2. Units are in values of solar masses.
- **_a_**:  Ratio between a1 and a2. Unitless.
- **_a_ crp**:  Limiting factor of corotating systems (prograde). Unitless.
- **_a_ crr**:  Limiting factor of counterrotating systems (retrograde). Unitless.
- **rH1, rH2**: Hill radius of 30 Ari Bb and C, respectively. Units are in values of astronomical units (au).

## Example of output
```
Parameter	Data
-------------------
System Information
m1 (M*)		1.220
m2 (M*)		0.140
m3 (M*)		0.500
M  (M*)		1.360
a1 (au)		0.967
a2 (au)		21.9
-------------------
Stellar Components
α		0.0442
α_crp		0.2113
α_crr		0.2242
Bb rH (au)	0.3261
C rH (au)	10.8772

RESULT:
α <= α_crr
System is stable
```

### References
[^1]:[Boyle L, Cuntz M. 2021. Orbital Stability of Planet-hosting Triple-star Systems according to Hill: Applications to Alpha Centauri and 16 Cygni. Res Notes AAS. 5(12):285. doi:10.3847/2515-5172/ac45f1.](https://iopscience-iop-org.ezproxy.uta.edu/article/10.3847/2515-5172/ac45f1)
