function [ output_args ] = Tools( input_args )
%TOOLS Summary of this function goes here
%   Detailed explanation goes here


end

function [ train_data, train_class ] = Load__Train_Data(  )
%TOOLS Summary of this function goes here
%   Detailed explanation goes here
    train_data = load('proj2_data\xtrain.txt');
    train_class = load('proj2_data\ctrain.txt');
end

function [ test_data, test_class, test_prob ] = Load_Test_Data(  )
%TOOLS Summary of this function goes here
%   Detailed explanation goes here
    test_prob = load('proj2_data\ptest.txt');
    test_data = load('proj2_data\ctrain.txt');
    test_class = load('proj2_data\ctrain.txt');
end

function [ feature] = Poly(x1, x2, N)
%TOOLS Summary of this function goes here
%   Detailed explanation goes here
    data_length = length(x1);
    n_dimensions = (N + 2) * (N + 1) / 2;
    feature = zeros(data_length, n_dimensions);
    feature(:,1) = 1;
    i_dimensions = 2;
    for i = 1:1:N
        for j = 0:1:i
            feature(:,i_dimensions) = (x1.^ j) .* (x2.^(i - j));
            i_dimensions = i_dimensions + 1;
        end
    end
end