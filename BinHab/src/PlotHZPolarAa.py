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

lineStyles = ['-', '--', ':']
star = 'AaAb'

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
        inner1.append(1.795)
        outer1.append(3.098)
        inner2.append(1.795)
        outer2.append(3.098)
    data['stab'] = 2.24052978710280
    f.close()
    
    data['degIn'] = deg
    data['degOut'] = deg
    if np.isnan(inner1[0]):
        data['inner'] = inner2
        data['outer'] = outer2
    else:
        data['inner'] = inner1
        data['outer'] = outer1
        
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
    r1 = fillOut * 0.03
    r2 = r1 * 0.5
    xPri = r1 * np.cos(np.linspace(0, 2 * np.pi, 200)) - disPri
    yPri = r1 * np.sin(np.linspace(0, 2 * np.pi, 200))
    xSec = r2 * np.cos(np.linspace(0, 2 * np.pi, 200)) + disSec
    ySec = r2 * np.sin(np.linspace(0, 2 * np.pi, 200))
    (angPri, radPri) = zip(*[cart2pol(a, b) for a, b in zip(xPri, yPri)])
    (angSec, radSec) = zip(*[cart2pol(a, b) for a, b in zip(xSec, ySec)])
    plt.fill(angPri, radPri, color = '#A52A2A')
    plt.fill(angSec, radSec, color = '#A52A2A')
elif figureSetting['type'] == 2:
    fillIn = max(data['inner'])
    fillOut = min(min(data['outer']), data['stab'])
    plt.fill(cir, fillOut * 0.02 * np.ones(len(cir)), color = '#A52A2A')

# Fill HZ
plt.fill_between(cir, fillIn * np.ones(len(cir)), fillOut * np.ones(len(cir)), facecolor = '#C8C8C8')

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
if figureSetting['title'] != '':
    plt.title(figureSetting['title'], pad = 25, fontsize = 15)
legendHandles = []
legendLabels = []
if figureSetting['legend1'] != '':
    legendHandles.append(lin1)
    legendLabels.append(figureSetting['legend1'])
if figureSetting['legend2'] != '':
    legendHandles.append(lin2)
    legendLabels.append(figureSetting['legend2'])
if figureSetting['legend3'] != '':
    legendHandles.append(lin3)
    legendLabels.append(figureSetting['legend3'])
if len(legendHandles) > 0:
    plt.legend(legendHandles, legendLabels, loc = 'upper center', bbox_to_anchor = (0.5, -0.08), ncol = 3)#

# Save figure 
plt.tight_layout()
fig.savefig('dat/'+star+'Poster.png')