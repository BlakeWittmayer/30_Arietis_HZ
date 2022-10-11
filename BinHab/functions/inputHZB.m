function [l_in,l_out] = inputHZB()
T = readtable('Table 2.csv','VariableNamingRule','preserve'); % Habitability Limits for the Sun
clc;
disp(T);
while true
    in = input("Choose an inner boundary:\n");
    if in == 4
        fprintf("Selected choice is not a boundary\n");
    elseif (in > 4 || in < 1)
        fprintf("Select a boundary within the range of 1-3\n");
    else
        l_in = table2array(T(in,2));
        break
    end
end
while true
    out = input("Choose an outer boundary:\n");
    if out == 4
        fprintf("Selected choice is not a boundary\n");
    elseif (out > 7 || out < 4)
        fprintf("Select a boundary within the range of 5-7\n");
    else
        l_out = table2array(T(out,2));
        break
    end
end
end
