% Housekeeping
clear; 
clc;
close all

% Inputs
Star1.M = 1.22;
Star1.SpType = 'F6';
Star1.T_eff = 6211;
Star1.R = 1.34;
Star1.L = 2.396;

Star2.M = 0.1403;
Star2.SpType = 'M5';
Star2.T_eff = 3060;
Star2.R = 0.196;
Star2.L = 0.003;

a_bin = 0.967; % Semi-major axis of binary
n = 250; % Number of points

% Ask user to pick boundaries
[l_in,l_out] = inputHZB(2,6);

% Calculations
phi = linspace(0,pi,n);
a = 0.5*a_bin;

d_in = Ypoly(Star1,Star2,l_in,a,n);
d_out = Ypoly(Star1,Star2,l_out,a,n); % Currently unused

% z is the radiative habitable zone (RHZ)
z_in = z_i(Star1,Star2,l_in,a,n);
z_out = z_i(Star1,Star2,l_out,a,n);

% Generate plot
genPlot(d_in,d_out,z_in,z_out,n,a);
