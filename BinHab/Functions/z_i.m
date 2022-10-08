function z = z_i(Star1,Star2,s_l,a,n)
phi = 0:pi()/n:pi()-pi()/n;
theta = 0:pi()/n:2*pi()-pi()/n;
clear Star1.Lp_il Star2.Lp_il

Lp_1l = Lprime_il(Star1.L,s_l,Star1.T_eff);
Lp_2l = Lprime_il(Star2.L,s_l,Star2.T_eff);

A_2 = 2*a^(2)*(1-2*cos(phi).^2)-s_l^(2)*(Lp_1l+Lp_2l);
A_1 = 2*a*s_l^(2)*cos(phi).*(Lp_1l+Lp_2l);
A_0 = a^(4) - a^(2)*s_l^(2)*(Lp_1l+Lp_2l);

ahat_2 = -A_2;
ahat_1 = -4*A_0;
ahat_0 = 4*A_0*A_2-A_1.^2;

Q = ahat_1/3-(ahat_2.^2)/9;
R = -ahat_0/2+(ahat_1*ahat_2)/6-(ahat_2.^3)/27;

D_3 = Q.^3 + R.^2;

S = (R+D_3.^(1/2)).^(1/3);
T = (R-D_3.^(1/2)).^(1/3);

y_1 = -ahat_2/3 + (S+T);

C = sqrt(-2*a^(2)*(1-2*cos(phi).^(2))+s_l^(2)*(Lp_1l+Lp_2l)+y_1);
D = sqrt(s_l^(2)*(Lp_1l+Lp_2l)+4*a*s_l^(2)*(Lp_1l-Lp_2l)*C.^(-1).*cos(phi)-2*a^(2)*(1-2*cos(phi).^(2))-y_1);
E = sqrt(s_l^(2)*(Lp_1l+Lp_2l)-4*a*s_l^(2)*(Lp_1l-Lp_2l)*C.^(-1).*cos(phi)-2*a^(2)*(1-2*cos(phi).^(2))-y_1);

z(1,:) = real(-C./2 - D./2);
z(2,:) = real(C./2 + E./2);
z(:,1) = NaN;
end
