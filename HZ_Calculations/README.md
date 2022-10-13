# Habitable_Zone_Calculations.m
This file plots the stellar habitable zone (HZ) boundaries for 30 Arietis using the expression given from Kopparapu et al. (2014) paper[^1][^2].
![HZ](https://user-images.githubusercontent.com/89792296/195188334-ec0e253b-a295-483d-ae70-bc610c9c137b.png)
## Usage
Input data is assigned into the `Star` structure array.  
The order of the structure is

* **Star** - Structure array
  * **Name** - Name of star
  * **T_eff** - Effective stellar temperature \[K\]
  * **L** - Stellar luminousity \[L<sub>⊙</sub>\]  
  * **HZ** - Habitable zone distances \[AU\] 

`HZ_Dist(T_eff,L)`  
Outputs 1x4 double `dist` containing HZ distances in units of AU. 

1. Recent Venus
2. Runaway Greenhouse
3. Maximum Greenhouse
4. Early Mars
  
## Contact
Blake Wittmayer - blake.wittmayer@mavs.uta.edu 
Manfred Cuntz - cuntz@uta.edu  
Univerisity of Texas at Arlington  

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

[^1]:["Habitable Zones Around Main-Sequence Stars: Dependence on Planetary Mass" by Kopparapu et al.(2014), Astrophysical Journal Letters, 787, L29](https://iopscience-iop-org.ezproxy.uta.edu/article/10.1088/2041-8205/787/2/L29)
[^2]:["Habitable Zones Around Main-Sequence Stars: New Estimates" by Kopparapu et al.(2013), Astrophysical Journal, 765, 131](https://iopscience-iop-org.ezproxy.uta.edu/article/10.1088/0004-637X/765/2/131)
