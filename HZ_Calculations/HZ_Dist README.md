`HZ_Dist(T_eff,L)`  
T_eff = Effective stellar temperature \[K\]  
L = Stellar luminousity \[L<sub>⊙</sub>\]  

## Description
This function calculates the stellar habitable zone (HZ) boundaries using coefficients and expressions given from Kopparapu et al. (2014)[^1][^2] paper. 
This function only calculates HZ distances relative to 1 Earth mass. 

Outputs 1x4 double `dist` containing HZ distances in units of AU. 

1. Recent Venus
2. Runaway Greenhouse
3. Maximum Greenhouse
4. Early Mars

### Contact
Blake Wittmayer & Manfred Cuntz  
Univerisity of Texas at Arlington  
blake.wittmayer@mavs.uta.edu  
cuntz@uta.edu

[^1]:["Habitable Zones Around Main-Sequence Stars: Dependence on Planetary Mass" by Kopparapu et al.(2014), Astrophysical Journal Letters, 787, L29](https://iopscience-iop-org.ezproxy.uta.edu/article/10.1088/2041-8205/787/2/L29)
[^2]:["Habitable Zones Around Main-Sequence Stars: New Estimates" by Kopparapu et al.(2013), Astrophysical Journal, 765, 131](https://iopscience-iop-org.ezproxy.uta.edu/article/10.1088/0004-637X/765/2/131)
