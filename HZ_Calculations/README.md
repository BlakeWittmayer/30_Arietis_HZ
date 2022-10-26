# Habitable_Zone_Calculations.m
This program calculates and plots the stellar habitable zone boundaries (HZB) for 30 Arietis using the methods described by Kopparapu et al. (2014) paper[^1][^2].
![untitled](https://user-images.githubusercontent.com/89792296/198120045-f9aa0306-9fed-4326-8716-15e7178ea1cc.png)
## Usage
Data is assigned into the `Star` structure array.  
The structure is comprised of

* **Star** - Structure array
  * **Name** - Name of star
  * **T_eff** - Effective stellar temperature \[K\]
  * **L** - Stellar luminousity \[L<sub>⊙</sub>\]  
  * **HZ** - Habitable zone distances \[AU\] 

The coefficients used in HZ_Dist.m are stored in Coeff.csv. The following table displays the coefficients used for calculating the habitable zone around a star for a planet of 1 M<sub>⊕</sub>
| Constant  | Recent Venus | Runaway Greenhouse | Maximum Greenhouse | Early Mars |
| ------------- | -------------: | -------------: | -------------: | -------------: |
| S<sub>eff⊙</sub> | 1.776  | 1.107 | 0.356 | 0.32 |
| a  | 2.136 × 10<sup>-4</sup>  | 1.332 × 10<sup>-4</sup> | 6.171 × 10<sup>−5</sup> | 5.547 × 10<sup>−5</sup> |
| b  | 2.533 × 10<sup>−8</sup> | 1.58 × 10<sup>−8</sup> | 1.698 × 10<sup>−9</sup> | 1.526 × 10<sup>−9</sup> |
| c  | −1.332 × 10<sup>−11</sup> | −8.308 × 10<sup>−12</sup> | −3.198 × 10<sup>−12</sup> | −2.874 × 10<sup>−12</sup> |
| d  | −3.097 × 10<sup>−15</sup> | −1.931 × 10<sup>−15</sup> | −5.575 × 10<sup>−16</sup> | −5.011 × 10<sup>−16</sup> |

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
