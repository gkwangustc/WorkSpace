raw_data = load('wine.data');

k_max = 50;
N = 100;
final_accuracy = zeros(1,k_max);
zscore_final_accuracy = zeros(1,k_max);
accuracy = zeros(1,N);
zscore_accuracy = zeros(1,N);
% partition the raw_data into fold_number parts to cross-valid
for k = 1:1:k_max
    for j = 1:1:N
        shuffle_data = raw_data(randperm(length(raw_data)),:);
        zscore_shuffle_data = shuffle_data;
        zscore_shuffle_data(:,(2:end)) = zscore(zscore_shuffle_data(:,(2:end)));
        accuracy(j) = knn_my(shuffle_data,shuffle_data,k);
        zscore_accuracy(j) = knn_my(zscore_shuffle_data,zscore_shuffle_data,k);
    end
    % compute the mean accuracy
    final_accuracy(k) = mean(accuracy);
    zscore_final_accuracy(k) = mean(zscore_accuracy);
end
plot(final_accuracy);
hold on;
plot(zscore_final_accuracy);
legend('accuracy curve','accuracy curve with normalization');
title('The accuracy using all data to train and test');
xlabel('k');
ylabel('accuracy');