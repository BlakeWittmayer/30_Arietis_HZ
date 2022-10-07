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
n = 250; % Coefficient of precision

% Ask user to pick boundaries
[l_in,l_out] = inputHZB(2,7);

% Calculations
phi = 0:pi()/n:pi()-pi()/n;
a = 0.5*a_bin;
mu = Star2.M/(Star1.M+Star2.M);

d_in = Ypoly(Star1,Star2,l_in,a,n);
d_out = Ypoly(Star1,Star2,l_out,a,n);

% z is the radiative habitable limit (RHL)
z_in = z_i(Star1,Star2,l_in,a,n);
z_out = z_i(Star1,Star2,l_out,a,n);

% Generate plot
polarplot(phi,d_in);
hold on
polarplot(phi,-d_in);
polarplot(phi,d_out);
polarplot(phi,-d_out);
polarplot(phi,z_in);
polarplot(phi,z_out);
polarplot(pi(),a,'.','Color','#EDB120','MarkerSize',30);
polarplot(0,a,'.','Color','#EDB120','MarkerSize',15);
hold off
