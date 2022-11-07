% Housekeeping
clear; 
clc;
close all
addpath('functions');
addpath('input');

% Input Data
StarA.Name = '30 Ari Aa';
StarA.T_eff = 8647.00;                   % Effective stellar temperature
StarA.L = 4.165;                         % Stellar luminosity

StarB.Name = '30 Ari Ba';
StarB.T_eff = 6211.27;
StarB.L = 2.396;

StarA.HZ = HZ_Dist(StarA.T_eff,StarA.L); % HZ distances for 30 Ari Aa [AU]
StarB.HZ = HZ_Dist(StarB.T_eff,StarB.L); % HZ distances for 30 Ari Ba [AU]

% Graphical settings
figure('Name','30 Arietis Habitable Zones',NumberTitle='off', ...
    units='normalized',outerposition=[0 0 1 1]);
tiledlayout(2,1);

% Top plot
nexttile
plot(0,0,'.',Color='#EDB120',MarkerSize=60); % Star at origin
hold on
formatPlot(StarA);
hold off

% Bottom plot
nexttile
plot(0,0,'.',Color='#EDB120',MarkerSize=60); % Star at origin 
hold on
formatPlot(StarB);
hold off
