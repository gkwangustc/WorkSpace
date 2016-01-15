raw_data = load('wine.data');
train_data = raw_data(:,(2:end));
category_1 = train_data((1:59),:);
category_2 = train_data((60:130),:);
category_3 = train_data((130:end),:);

figure(1)
boxplot(train_data);
title('The boxplot of the 13 variables');

figure(2)
for i = 1:1:4
    [f,x] = ecdf(train_data(:,i));
    subplot(2,2,i);
    plot(x,f);
    title(strcat('the Empirical CDF of ','',int2str(i),'th variables'));
end

figure(3)
parallelcoords(train_data,'Group',raw_data(:,1));
title('data displayed with parallel coordinates');
hold on;


boxplot(train_data);
title('The boxplot of the 13 variables');
[~, train_data] = pca(train_data);
cdata = train_data(:,1:3);
index1 = find(raw_data(:, 1) == 1);
index2 = find(raw_data(:, 1) == 2);
index3 = find(raw_data(:, 1) == 3);
figure(3)
scatter3(cdata(index1, 1), cdata(index1, 2), cdata(index1, 3), '*r');
hold on
scatter3(cdata(index2, 1), cdata(index2, 2), cdata(index2, 3), '+b');
scatter3(cdata(index3, 1), cdata(index3, 2), cdata(index3, 3), 'og');

