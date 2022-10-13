% This function calculates the oribtal stability limit of a binary system
function a_cr = StabLimit(Star1,Star2,a_bin,e_bin)
T = readtable('Table 3.csv','VariableNamingRule', ...
    'preserve');

A = table2array(T(1:3,3));
B = table2array(T(4:6,3));
C = table2array(T(7:9,3));
clear T;

if Star1.M > Star2.M
    m1 = Star1.M;
    m2 = Star2.M;
else
    m2 = Star1.M;
    m1 = Star2.M;
end
mu = m2/(m1+m2);

g = zeros(3);
for i = 0:1:2
    g(1,i+1) = B(i+1)*mu^i;
    g(2,i+1) = C(i+1)*mu^i;
    g(3,i+1) = A(i+1)*mu^i;
end

F_p = e_bin*sum(g(1,:))+(e_bin^2)*sum(g(2,:));
a_cr = a_bin*(sum(g(3,:))+F_p);
end