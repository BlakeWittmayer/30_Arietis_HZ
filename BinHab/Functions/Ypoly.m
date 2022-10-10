function eqn = Ypoly(Star1,Star2,s_l,a,n)
phi = linspace(0,pi,n);
clear Star1.Lp_il Star2.Lp_il

Lp_1l = Lprime_il(Star1.L,s_l,Star1.T_eff);
Lp_2l = Lprime_il(Star2.L,s_l,Star2.T_eff);

y = sym('y');
A_2 = 2*a^(2)*(1-2*cos(phi).^2)-s_l^(2)*(Lp_1l+Lp_2l);
A_1 = 2*a*s_l^(2)*cos(phi)*(Lp_1l+Lp_2l);
A_0 = a^(4) - a^(2)*s_l^(2)*(Lp_1l+Lp_2l);

m = y.^(3)-A_2.*y.^(2)-A_0.*y+(4*A_2.*A_0-A_1.^(2)) == 0;
eqn = zeros(2,n);
for k = 1:n
    c = vpasolve(m(k));
    eqn(1,k) = double(c(1));
    eqn(2,k) = -double(c(1));
end
clear y
end
