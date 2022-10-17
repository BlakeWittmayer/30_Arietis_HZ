% Housekeeping
clear; 
clc;
close all
addpath('functions');
addpath('input');

% Inputs
Star1.M = 1.22;         % Primary star stellar mass (M*)
Star1.T_eff = 6211;     % Primary star effective stellar temperature (K)
Star1.L = 2.396;        % Primary star stellar luminosity (L*)

Star2.M = 0.1403;       % Secondary star stellar mass (M*)
Star2.T_eff = 3060;     % Secondary star effective stellar temperature (K)
Star2.L = 0.003;        % Secondary star stellar luminosity (L*)

a_bin = 0.967;          % Semi-major axis of binary (au)
n = 180;                % Number of points
e = 0.18;               % Eccentricity

% Ask user to input habitable zone boundaries (HZB)
[l_in,l_out] = inputHZB();

% Calculations
phi = linspace(0,pi,n); % n points ranging from 0 to pi
a = 0.5*a_bin;          % Semidistance of binary separation (au)

a_cr = StabLimit(Star1,Star2,a_bin,e); % Inner stabilty limit (au)

% z is the radiative habitable zone (RHZ)
z_in = RHZ(Star1,Star2,l_in,a,n);
z_out = RHZ(Star1,Star2,l_out,a,n);

% Generate plot
genPlot(a_cr,z_in,z_out,n,a);
