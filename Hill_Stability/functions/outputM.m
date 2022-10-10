function outputM(m1,m2,m3)
formatSpec = 'm%d (M*)\t\t%5.3f\n';
fprintf(formatSpec,1,m1);
fprintf(formatSpec,2,m2);
fprintf(formatSpec,3,m3);
M = m1 + m2;
fprintf('M  (M*)\t\t%5.3f\n',M);
end