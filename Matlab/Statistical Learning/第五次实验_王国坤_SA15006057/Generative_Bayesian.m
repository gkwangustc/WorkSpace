function [ y_output ] = Generative_Bayesian( is_smooth )
%% this funciton can calcualte the output based on emprical distribution.
% is_smooth can determine whether to use laplace smooth.
x_1 = [1,1,1,1,1,2,2,2,2,2,3];
x_2 = ['s','m','m','s','s','s','m','m','l','l','l'];
y = [-1,-1,1,1,-1,-1,-1,1,1,1,1];
test_data = [1,'m'];
p_y = [length(find(y == -1))/length(y),length(find(y == 1))/length(y)];
y_varible = unique(y);
x1_varible = unique(x_1);
x2_varible = unique(x_2);
p_y_x1 = naive_distribution(y,x_1,y_varible,x1_varible,is_smooth);
p_y_x2 = naive_distribution(y,x_2,y_varible,x2_varible,is_smooth);
[m,index] = max(p_y_x1(:,find(x1_varible == test_data(1))).*p_y_x2(:,find(x2_varible == test_data(2))).*p_y');
y_output = y_varible(index);
end

function [ distribution_result ] = naive_distribution( y,x,y_varible,x_varible,is_smooth)
%% this funciton can calcualte the conditional probability.
% is_smooth can determine whether to use laplace smooth.
    distribution_result = zeros(length(y_varible),length(x_varible));
    for i = 1:length(y_varible)
        for j = 1:length(x_varible)
            if is_smooth== 0;
                distribution_result(i,j) = length(intersect(find(y == y_varible(i)),find(x == x_varible(j))))/length(find(y == y_varible(i)));
            else
                distribution_result(i,j) = (length(intersect(find(y == y_varible(i)),find(x == x_varible(j))))+1)/(length(find(y == y_varible(i)))+length(x_varible));
            end 
        end
    end
end

