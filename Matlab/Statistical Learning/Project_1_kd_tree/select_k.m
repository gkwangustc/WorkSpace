%% excute the cross_valid N time and compute the mean accuracy 
N = 100;
k_max = 50;
fold_number = 5;
accuracy = zeros(1,length(k_max));
for i = 1:1:N
    accuracy = accuracy + five_fold(k_max,fold_number);
end
plot(accuracy/N);
[M,I] = max(accuracy);