function [ final_accuracy ] = five_fold( k_max,fold_number)
%% FIVE_FOLD use this function to partition the data into fold_number and compute mean accuracy  
%   此处显示详细说明
raw_data = load('wine.data');
% shuffle the data before partition
shuffle_data = raw_data(randperm(length(raw_data)),:);
% whether normalization the data
is_zscore = 1;
is_pca = 1;
if is_zscore == 1  
    shuffle_data(:,(2:end)) = zscore(shuffle_data(:,(2:end)));
 end
interval = ceil(length(shuffle_data)/fold_number);
final_accuracy = zeros(1,k_max);
% partition the raw_data into fold_number parts to cross-valid
for k = 1:1:k_max
    accuracy = zeros(1,fold_number);
    for i = 1:1:fold_number
        index_start = (i-1)*interval+1;
        index_end = min(i*interval,length(shuffle_data));
        test_data = shuffle_data(index_start:index_end,:);
        train_data = shuffle_data;
        train_data(index_start:index_end,:)=[];
%         if is_zscore == 1       
%             train_data(:,(2:end)) = zscore(train_data(:,(2:end)));
%             test_data(:,(2:end)) = zscore(test_data(:,(2:end)));
%         end
        if is_pca == 1       
            [train_data(:,2:end),test_data(:,2:end)] = pca_wine(train_data(:,(2:end)),test_data(:,(2:end)),13);
%             train_data(:,8:end)=[];
%             test_data(:,8:end)=[];
        end
%         [train_data(:,2:7),test_data(:,2:7)] = pca_wine(train_data(:,(2:end)),test_data(:,(2:end)),6 , is_zscore);
%         train_data(:,8:end)=[];
%         test_data(:,8:end)=[];
        accuracy(i) = knn_my(train_data,test_data,k);
    end
    % compute the mean accuracy
    final_accuracy(k) = mean(accuracy);
end
end

