function [ accuracy ] = knn_my( train_data ,test_data,k)
%% KNN_MY use train_data to construct a model, and use test data to compute perfromance with knn, and return accuarcy
% train_data and test_data include data and label
wine_train_data = train_data(:,(2:end));
wine_train_label = train_data(:,1);
wine_test_data = test_data(:,(2:end));
wine_test_label = test_data(:,1);

record_distance =  zeros(k,length(test_data));
% compute the Euclidean distance between test_data and train_data
distance = pdist2(wine_test_data,wine_train_data);

% find k point whose distance is smallest and get the label of them
for i = 1:k
    [M, index] = min(distance, [], 2); % find the index of the point whose distance is smallest
    label(i, :) = wine_train_label(index)'; % get label
    record_distance(i, :) = M';
    index = sub2ind(size(distance), 1:size(distance, 1), index');% calculate the linear index of that point
    distance(index) = Inf;% set the distance of this point to infinite to find the second smallest distance in the next loop
end

% simple voting - find the mode of label
label = mode(label, 1)';
% label = sign(sum(record_distance.^(-1).*(label-2),1)/k)+2;
% label = label';
% compute accuracy
accuracy = sum(label == wine_test_label)/length(wine_test_label);
end

