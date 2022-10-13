function z_i = Zpoly(Star1,Star2,s_l,a,n)
p = linspace(0,pi,n);

Lp_1l = Lprime_il(Star1.L,s_l,Star1.T_eff);                 % Equation (7)
Lp_2l = Lprime_il(Star2.L,s_l,Star2.T_eff);                 % Equation (7)

z_i = zeros(4,n);
for k = 1:n
    phi = p(k);
    z = sym('z');

    A_2 = 2*a^(2)*(1-2*cos(phi).^2)-s_l^(2)*(Lp_1l+Lp_2l);  % Equation (9a)
    A_1 = 2*a*s_l^(2)*cos(phi)*(Lp_1l+Lp_2l);               % Equation (9b)
    A_0 = a^(4) - a^(2)*s_l^(2)*(Lp_1l+Lp_2l);              % Equation (9c)

    m = z^4 + A_2.*z^2 + A_1.*z + A_0 == 0;                 % Equation (8)
    z_i(:,k) = real(double(vpasolve(m)));
end