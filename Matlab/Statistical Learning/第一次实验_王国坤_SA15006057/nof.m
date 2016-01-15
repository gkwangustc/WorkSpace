%% Solve the problem
% author:Guokun Wang
clear;
x0 = [-0.1,0.1];
options = optimset('largescale','off','display','iter');
[x,fval,exitflag,output]=fmincon(@f_obj,x0,[],[],[],[],[],[],@f_con,options);