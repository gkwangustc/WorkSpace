clear all;
close all;
clc;
fid = fopen('bezdekIris.data');
tem = textscan(fid,'%f,%f,%f,%f,%s');
Iris_Data = cell2mat(tem(1:4));
[zscore_iris, mu, sigma] = zscore(Iris_Data);
Iris_Cov_Matrix = cov(zscore_iris);
Iris_Cov_Matrix_raw = cov(Iris_Data);
KL_Trans = pcacov(Iris_Cov_Matrix);


boxplot(Iris_Data);
