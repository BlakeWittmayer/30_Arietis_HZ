% Housekeeping
clear;
clc;
close all

% Input Data
% Stellar masses of components [Solar Mass, M*]
m1 = 1.22;      % 30 Ari Ba
m2 = 0.1403;    % 30 Ari Bb
m3 = 0.50;      % 30 Ari C
% Semi-major Axes [AU]
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

%% Functions
function [crp, crr] = Hill3Body(m1,m2,m3)
M2 = m1 + m2;
B1 = 1.48035831;
B2 = 1.7282208;
B3 = 0.84283395;
B4 = 0.54368114;
crp = (B1*(M2/(81*m3))^(1/3))*(1-B2*(M2/(81*m3))^(1/3));
crr = (B3*(M2/(81*m3))^(1/3))*(1-B4*(M2/(81*m3))^(1/3));
end

function outputM(m1,m2,m3)
formatSpec = 'm%d (M*)\t\t%5.3f\n';
fprintf(formatSpec,1,m1);
fprintf(formatSpec,2,m2);
fprintf(formatSpec,3,m3);
M = m1 + m2;
fprintf('M  (M*)\t\t%5.3f\n',M);
end

function outputA(a1,a2)
fprintf('a1 (AU)\t\t%4.3f\n',a1);
fprintf('a2 (AU)\t\t%4.1f\n',a2);
end

function outputC(a,crp,crr)
fprintf('\x3B1\t\t\t%6.4f\n',a);
fprintf('\x3B1_crp\t\t%6.4f\n',crp);
fprintf('\x3B1_crr\t\t%6.4f\n',crr);
end

function rH = hillRadius(a,m,M)
rH = a*nthroot(m/(3*M),3);
end

function outputRH(rH1,rH2)
fprintf('Bb rH (AU)\t%6.4f\n',rH1);
fprintf('C rH (AU)\t%6.4f\n',rH2);
end
