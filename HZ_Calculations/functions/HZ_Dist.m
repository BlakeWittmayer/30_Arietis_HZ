function [dist] = HZ_Dist(T_eff,L)
% Import table of coefficients 
coeff = readtable('Coeff.csv'); % table of coefficients
coeff.Properties.VariableNames = {'Recent Venus' 'Runaway Greenhouse' 
    'Maximum Greenhouse' 'Early Mars'};
coeff.Properties.RowNames = {'S_effSun' 'a' 'b' 'c' 'd'};

Tstar = T_eff - 5780; 
S_eff = zeros(1,4); % Effective solar flux array [W m^-2]
dist = zeros(1,4); % Habitable zone distance array [AU]

for i = 1:1:4
    S_effSun = coeff{1,i};
    a = coeff{2,i};
    b = coeff{3,i};
    c = coeff{4,i};
    d = coeff{5,i};

    S_eff(1,i) = S_effSun+a*Tstar+b*Tstar^2+c*Tstar^3+d*Tstar^4; 
    dist(1,i) =  (L/S_eff(1,i))^.5;
end
end
