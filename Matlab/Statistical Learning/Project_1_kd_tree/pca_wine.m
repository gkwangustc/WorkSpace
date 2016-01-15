function [ pca_train_data,pca_test_data] = pca_wine( train_data,test_data,p_dimension)
%PCA_WINE 此处显示有关此函数的摘要
%   此处显示详细说明
[~,pca_train_data]=pca(train_data);
pca_train_data = pca_train_data(:,1:p_dimension);
[~,pca_test_data]=pca(test_data);
pca_test_data = pca_test_data(:,1:p_dimension);
end

