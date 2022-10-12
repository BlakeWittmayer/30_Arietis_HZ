# -*- coding: utf-8 -*-
"""
Created on Tue Oct  4 14:24:36 2022

@author: Blake Wittmayer
Contact: blake.wittmayer@mavs.uta.edu

Department of Physics,
University of Texas at Arlington,
Arlington, TX 76019, USA
"""

###############################################
# Functions
###############################################
def hillRadius(a,m,M):
    rH = a*(m/(3*M))**(1/3)
    return rH

def hill3Body(m1,m2,m3):
    M2 = m1 + m2
    B1 = 1.48035831
    B2 = 1.7282208
    B3 = 0.84283395
    B4 = 0.54368114 
    y = (M2/(81*m3))**(1/3)
    crp = B1*y*(1-B2*y)
    crr = B3*y*(1-B4*y)
    return crp,crr;

def hillStable(a,crr):
    if a <= crr:
        print("\u03B1 <= \u03B1_crr\nSystem is stable")
    elif a > crr:
        print("\u03B1 > \u03B1_crr\nSystem is not stable")

###############################################
# Input Data
###############################################
# Stellar masses of components [Solar Mass, M*]
m1 = 1.22       # 30 Ari Ba
m2 = 0.1403     # 30 Ari Bb
m3 = 0.50       # 30 Ari C
# Semi-major Axes [au]
a1 = 0.967      # Primary Ba & companion Bb
a2 = 21.9       # Primary B & companion C

###############################################
# Calculations
###############################################
M = m1 + m2
crp,crr = hill3Body(m1,m2,m3)
a = a1/a2
rH1 = hillRadius(a1,m2,m1)
rH2 = hillRadius(a2,m3,M)

###############################################
# Table
###############################################
# Build table
from tabulate import tabulate as tabl
SystemInfo = [["m1 (M*)",m1],["m2 (M*)",m2],["m3 (M*)",m3],["M  (M*)",M],
              ["a1 (au)",a1],["a2 (au)",a2]]
StelComp = [["\u03B1",a],["\u03B1_crp",crp],["\u03B1_crr",crr],
            ["Bb rH (au)",rH1],["C rH (au)",rH2]]
headers = ["Parameter","Data"]

###############################################
# Output Data
###############################################
print(" System Information")
print(tabl(SystemInfo, headers, tablefmt="simple", numalign="right", 
           floatfmt="5.3f"))
print("\n Stellar Components")
print(tabl(StelComp,headers,tablefmt="simple", numalign="right", 
           floatfmt="6.4f"))
print("\nHill Stability Result:")
hillStable(a,crr)