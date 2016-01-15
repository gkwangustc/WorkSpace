raw_data = load('wine.data');

k_max = 10;
N = 100;
final_accuracy = zeros(1,k_max);
accuracy = zeros(1,N);
% partition the raw_data into fold_number parts to cross-valid
for k = 1:1:k_max
    for j = 1:1:N
        replace_index = zeros(length(raw_data),1);
        for i = 1:1:length(raw_data)
            replace_index(i) = round(rand(1,1)*(length(raw_data)-1))+1;
        end
        train_data = raw_data(replace_index,:);
        test_index = 1:1:length(raw_data);
        test_index(unique(replace_index)) = [];
        test_data = raw_data(test_index,:);
        [train_data(:,2:7),test_data(:,2:7)] = pca_wine(train_data(:,(2:end)),test_data(:,(2:end)),6 , 0);
        train_data(:,8:end)=[];
        test_data(:,8:end)=[];
        accuracy(j) = knn_my(train_data,test_data,k);
    end
    % compute the mean accuracy
    final_accuracy(k) = mean(accuracy);
end
