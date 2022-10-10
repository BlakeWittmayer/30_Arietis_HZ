% Housekeeping
clear;
clc;
close all
addpath('functions');

% Input Data
% Stellar masses of components [Solar Mass, M*]
m1 = 1.22;      % 30 Ari Ba
m2 = 0.1403;    % 30 Ari Bb
m3 = 0.50;      % 30 Ari C
% Semi-major Axes [au]
a1 = 0.967;     % Primary Ba & companion Bb
a2 = 21.9;      % Primary B & companion C

% Calculations
[crp,crr] = Hill3Body(m1,m2,m3);
a = a1/a2;
rH1 = hillRadius(a1,m2,m1);
rH2 = hillRadius(a2,m3,m1+m2);

% Output Data
fprintf('Parameter\tData\n-------------------\n');
fprintf('System Information\n');
outputM(m1,m2,m3);
outputA(a1,a2);
fprintf('-------------------\nStellar Components\n');
outputC(a,crp,crr);
outputRH(rH1,rH2);

% Determine if system is stable
fprintf('\nRESULT:\n');
if a <= crr
    fprintf('\x3B1 <= \x3B1_crr\nSystem is stable\n');
elseif a > crr
    fprintf('\x3B1 > \x3B1_crr\nSystem is not stable\n');
end