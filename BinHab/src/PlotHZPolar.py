from cmath import pi
from xml.etree.ElementTree import PI
import matplotlib.pyplot as plt
import math
import numpy as np
from decimal import *
import sys
sys.path.append('../')

def cart2pol(x, y):
    rho = np.sqrt(x ** 2 + y ** 2)
    phi = np.arctan2(y, x)
    return (phi, rho)
    
def catStypeData(a, b, c):
    return a[0: c + 1] + list(reversed(b[0: c]))

def Convert(lst):
    return [ -i for i in lst ]

lineStyles = ['-', '--', ':']
star = 'BaC'

# Line order: Inner, Outer, Stability limit
# Line styles: solid, dashed, dotted

# Read Settings
figureSetting = {}
fs = open('dat/'+star+'PolarIN.DAT', 'r')
lines = fs.readlines()

figureSetting['ABIN'] = float(lines[0])             #1  SEMI-MAJOR AXIS OF STAR SYSTEM
figureSetting['EBIN'] = float(lines[1])             #2  ECCENTRICITY OF STAR SYSTEM
figureSetting['AM1'] = float(lines[4])              #5  MASS OF STAR1
figureSetting['AM2'] = float(lines[7])              #8  MASS OF STAR2
figureSetting['type'] = int(lines[12])              #13 1 = P/PT-TYPE, 2 = S/ST-TYPE

figureSetting['title'] = lines[13].rstrip()         #14 IGNORE
figureSetting['rMax'] = float(lines[14])            #15 IGNORE

figureSetting['lineStyle1'] = int(lines[15])        #16 1
figureSetting['lineColor1'] = lines[16].rstrip()    #17 r
figureSetting['legend1'] = lines[17].rstrip()       #18 Runaway Greenhouse

figureSetting['lineStyle2'] = int(lines[18])        #19 2
figureSetting['lineColor2'] = lines[19].rstrip()    #20 b
figureSetting['legend2'] = lines[20].rstrip()       #21 Maximum Greenhouse

figureSetting['lineStyle3'] = int(lines[21])        #22 3
figureSetting['lineColor3'] = lines[22].rstrip()    #23 k
figureSetting['legend3'] = lines[23].rstrip()       #24 Stability Limit

fs.close()

# Data Reading and Processing
data = {}
if figureSetting['type'] == 1:    
    dis = (0.5 - figureSetting['AM2'] / (figureSetting['AM1'] + figureSetting['AM2'])) * figureSetting['ABIN'] * figureSetting['EBIN']
    f = open('dat/'+star+'PolarOUT.DAT', "r")
    lines = f.readlines()
    deg = []
    inner1 = []
    inner2 = []
    outer1 = []
    outer2 = []
    for line in lines:
        deg.append(float(line.split()[0]))
        inner1.append(float(line.split()[1]))
        outer1.append(float(line.split()[2]))
        inner2.append(float(line.split()[3]))
        outer2.append(float(line.split()[4]))
    data['stab'] = float(line.rstrip().split()[5])
    f.close()
    
    data['degIn'] = deg
    data['degOut'] = deg
    if np.isnan(inner1[0]):
        data['inner'] = inner2
        data['outer'] = outer2
    else:
        data['inner'] = inner1
        data['outer'] = outer1
        
elif figureSetting['type'] == 2:
    dis = figureSetting['ABIN'] / 2
    f = open('dat/'+star+'PolarOUT.DAT', "r")
    lines = f.readlines()
    deg = []
    inner1 = []
    inner2 = []
    outer1 = []
    outer2 = []
    outer3 = []
    outer4 = []
    for line in lines:
        deg.append(float(line.split()[0]))
        inner1.append(float(line.split()[1]))
        inner2.append(float(line.split()[2]))
        outer1.append(float(line.split()[3]))
        outer2.append(float(line.split()[4]))
        outer3.append(float(line.split()[5]))
        outer4.append(float(line.split()[6]))
    data['stab'] = float(line.rstrip().split()[7])
    f.close()
    
    lenI = np.where(~np.isnan(inner1))[0][-1]
    data['degIn'] = catStypeData(deg, deg, lenI)
    data['inner'] = catStypeData(inner1, inner2, lenI)
    if np.isnan(outer1[0]):
        if np.isnan(outer2[0]):
            lenO = np.where(~np.isnan(outer3))[0][-1]
            deg_mirror = [180 - i for i in deg]
            outer3_mirror = [-1 * i for i in outer3]
            data['degOut'] = catStypeData(deg_mirror, deg, lenO)
            data['outer'] = catStypeData(outer3_mirror, outer4, lenO)
        else:
            lenO = np.where(~np.isnan(outer2))[0][-1]
            deg_mirror = [180 - i for i in deg]
            data['degOut'] = catStypeData(deg_mirror, deg, lenO)
            data['outer'] = catStypeData(outer2, outer2, lenO)
    else:
        lenO = np.where(~np.isnan(outer1))[0][-1]
        data['degOut'] = catStypeData(deg, deg, lenO)
        data['outer'] = catStypeData(outer1, outer2, lenO)

# Converting coordinates
xIn = [np.cos(a * np.pi / 180) * b + dis for a, b in zip(data['degIn'], data['inner'])]
yIn = [np.sin(a * np.pi / 180) * b for a, b in zip(data['degIn'], data['inner'])]
xOut = [np.cos(a * np.pi / 180) * b + dis for a, b in zip(data['degOut'], data['outer'])]
yOut = [np.sin(a * np.pi / 180) * b for a, b in zip(data['degOut'], data['outer'])]

(data['degIn'], data['inner']) = zip(*[cart2pol(a, b) for a, b in zip(xIn, yIn)])
data['degIn'] = list(data['degIn']) + list(reversed([a * (-1) for a in data['degIn'][1: -2]]))
data['inner'] = list(data['inner']) + list(reversed(data['inner'][1: -2]))

(data['degOut'], data['outer']) = zip(*[cart2pol(a, b) for a, b in zip(xOut, yOut)])
data['degOut'] = list(data['degOut']) + list(reversed([a * (-1) for a in data['degOut'][1: -2]]))
data['outer']= list(data['outer'])+list(reversed(data['outer'][1: -2]))

# Plot HZ limits
cir = np.linspace(0, 2 * np.pi, 181)

fig = plt.figure()
lin1, = plt.polar(data['degIn'], data['inner'], color = figureSetting['lineColor1'], linestyle = lineStyles[figureSetting['lineStyle1'] - 1], linewidth = 2)
lin2, = plt.polar(data['degOut'], data['outer'], color = figureSetting['lineColor2'], linestyle = lineStyles[figureSetting['lineStyle2'] - 1], linewidth = 2)
lin3, = plt.polar(cir, data['stab'] * np.ones(len(cir)), color = figureSetting['lineColor3'], linestyle = lineStyles[figureSetting['lineStyle3'] - 1], linewidth = 2)

# Plot stars
if figureSetting['type'] == 1:
    fillIn = max(max(data['inner']), data['stab'])
    fillOut = min(data['outer'])
    disPri = figureSetting['ABIN'] * figureSetting['AM2'] / (figureSetting['AM1'] + figureSetting['AM2'])
    disSec = figureSetting['ABIN'] * figureSetting['AM1'] / (figureSetting['AM1'] + figureSetting['AM2'])
    r1 = fillOut * 0.05
    r2 = r1 * figureSetting['AM2'] / figureSetting['AM1'] * 4
    xPri = r1 * np.cos(np.linspace(0, 2 * np.pi, 200)) - disPri
    yPri = r1 * np.sin(np.linspace(0, 2 * np.pi, 200))
    xSec = r2 * np.cos(np.linspace(0, 2 * np.pi, 200)) + disSec
    ySec = r2 * np.sin(np.linspace(0, 2 * np.pi, 200))
    (angPri, radPri) = zip(*[cart2pol(a, b) for a, b in zip(xPri, yPri)])
    (angSec, radSec) = zip(*[cart2pol(a, b) for a, b in zip(xSec, ySec)])
    plt.fill(angPri, radPri, color = '#A52A2A')
    plt.fill(angSec, radSec, color = '#A52A2A')

# Fill HZ
if figureSetting['type'] == 1:
    plt.fill_between(cir, fillIn * np.ones(len(cir)), fillOut * np.ones(len(cir)), facecolor = '#C8C8C8')
if figureSetting['type'] == 2:
    # Only for case of star BaC
    if star == 'BaC':
        z1 = -3.86930740078491
        z2 = -1.60523004359302
        z3 = 2.56897768593958
        z4 = 2.90555975843836
        RHZin1 = dis + z2 
        RHZout1 = dis + z1
        RHZin2 = dis - z3
        RHZout2 = dis - z4
        plt.fill_between(cir, RHZin1 * np.ones(len(cir)), RHZout1 * np.ones(len(cir)), facecolor = '#C8C8C8')
        plt.fill_between(cir, RHZin2 * np.ones(len(cir)), RHZout2 * np.ones(len(cir)), facecolor = '#A3A2A2')
        # Make stars

        plt.polar(pi,(RHZin2+RHZout2)/2, marker='o', markersize=3.5, color = '#A52A2A')
        plt.polar(0,(RHZin1+RHZout1)/2, marker='o', markersize=2, color = '#A52A2A')


# Figure setting
ax = plt.gca()
ax.tick_params(axis='both', labelsize=12)
if figureSetting['rMax'] == 0:
    figureSetting['rMax'] = (math.ceil(2 * max(max(data['outer']), data['stab']))) / 2
ax.set_rlim(0, figureSetting['rMax'])

if figureSetting['rMax'] > 6 and figureSetting['rMax'] <= 10:
    ax.set_rticks(np.arange(0, figureSetting['rMax'] + 2, 2))
elif figureSetting['rMax'] > 3 and figureSetting['rMax'] <= 6:
    ax.set_rticks(np.arange(0, figureSetting['rMax'] + 1, 1))
elif figureSetting['rMax'] <= 3:
    ax.set_rticks(np.arange(0, figureSetting['rMax'] + 0.5, 0.5))

# Figure tile and legend
#legendHandles = []
#legendLabels = []
#if figureSetting['title'] != '':
#    plt.title(figureSetting['title'], pad = 25, fontsize = 15)
#if figureSetting['legend1'] != '':
#    legendHandles.append(lin1)
#    legendLabels.append(figureSetting['legend1'])
#if figureSetting['legend2'] != '':
#    legendHandles.append(lin2)
#    legendLabels.append(figureSetting['legend2'])
#if figureSetting['legend3'] != '':
#    legendHandles.append(lin3)
#    legendLabels.append(figureSetting['legend3'])
#if len(legendHandles) > 0:
#    plt.legend(legendHandles, legendLabels, loc = 'upper center', bbox_to_anchor = (0.5, -0.08), ncol = 3)

# Save figure 
plt.tight_layout()
#fig.savefig('dat/'+star+'Result.eps', format='eps')
fig.savefig('dat/'+star+'Result.png')