function [ accuracy ] = knn_my( train_data ,test_data,k)
%KNN_MY 此处显示有关此函数的摘要
%   此处显示详细说明
wine_train_data = train_data(:,(2:end));
wine_train_label = train_data(:,1);
wine_test_data = test_data(:,(2:end));
wine_test_label = test_data(:,1);
right_label = 0;
for i = 1:1:length(wine_test_label)
    distance = sum(abs(repmat(wine_test_data(i,:),length(wine_train_data),1) - wine_train_data).^2,2).^(1/2);
    [sort_distance,original_index] = sort(distance);
    label = wine_train_label(original_index(1:k));
    if(mode(label)==wine_test_label(i))
        right_label = right_label + 1;
    end
end
accuracy = right_label/length(wine_test_label);
end

