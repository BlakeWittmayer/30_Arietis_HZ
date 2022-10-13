% Housekeeping
clear; 
clc;
close all
addpath('functions');
addpath('input');

% Inputs
Star1.M = 1.22;
Star1.T_eff = 6211;
Star1.L = 2.396;

Star2.M = 0.1403;
Star2.T_eff = 3060;
Star2.L = 0.003;

a_bin = 0.967; % Semi-major axis of binary
n = 180; % Number of points

% Ask user to pick boundaries
[l_in,l_out] = inputHZB();

% Calculations
phi = linspace(0,pi,n); % n points ranging from 0 to pi
a = 0.5*a_bin; % Semidistance of binary separation

d_in = Ypoly(Star1,Star2,l_in,a,n);
% d_out = Ypoly(Star1,Star2,l_out,a,n); % Currently unused

% z is the radiative habitable zone (RHZ)
z_in = RHZ(Star1,Star2,l_in,a,n);
z_out = RHZ(Star1,Star2,l_out,a,n);

% Generate plot
genPlot(d_in,z_in,z_out,n,a);
