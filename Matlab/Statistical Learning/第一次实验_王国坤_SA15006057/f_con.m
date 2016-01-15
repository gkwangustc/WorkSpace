%% constrained function
% author:Guokun Wang
function [ c,ceq ] = f_con( x )
c = x(1)^2 - x(2);
ceq = x(1)+x(2);
end

