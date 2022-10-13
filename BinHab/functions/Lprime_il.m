function Lp_il = Lprime_il(L,s_l,T_eff)
    Lp_il = L/S_rel(s_l,T_eff);                             % Equation (7)
end

function S_relil = S_rel(s_l,T_eff)
if s_l<1
    a_z = 2.7619e-5;
    b_z = 3.8095e-9;
elseif s_l>1
    a_z = 1.3786e-4;
    b_z = 1.4286e-9;
end
T_star = T_eff - 5700;
S_relil = (s_l/(s_l-a_z*T_star-b_z*(T_star^(2))))^2;        % Equation (4)
end