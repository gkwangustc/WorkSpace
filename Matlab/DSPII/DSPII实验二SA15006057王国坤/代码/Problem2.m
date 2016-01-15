%% 产生信号并求相关值
% Guokun Wang SA15006057
% gkwang@mail.ustc.edu.cn
N = 20;
k = -N:N;
Rx_1 = 0.5 * cos(0.05 * pi * k);
Rx_2 = (k == 2) + 4 * (k == 1) + 6 * (k == 0) + 4 * (k == -1) + (k == -2);

figure(1);

stem(k,Rx_1, 'r');
hold on; 
stem(k,Rx_2, 'b');
xlabel('k');ylabel('Rx');
legend('Rx1', 'Rx2');
title('信号的自相关函数');

%% 进行线性增强
N = 100000;
n = 1:N;
delay = 11;
delta = 1e-6;
filter_order = 20;
white_noise = wgn(1, N + 2, 10 * log10(1));
x1 = sin(0.05 * pi * n + 2 * pi * rand);
x2 = white_noise(3:end) + 2 * white_noise(2:(end-1)) + white_noise(1:(end-2));
x = x1 + x2;
y = zeros(1, N);
y(delay + 1:end) = x(1:(end - delay));
y_re = zeros(1,N);
H = zeros(filter_order,1);
error = zeros(1,N);

for i = (delay + filter_order - 1):N-1
    index = fliplr((i - filter_order+2):(i + 1));
    y_re(i + 1) = H' * y(index)';
    error(i + 1)=x(i + 1) - y_re(i + 1)';
    H = H + delta*error(i + 1) * y(index)';
end

figure(2);

plot(99880:N,y_re(99880:N),'r');
hold on;
plot((99880:N),x1(99880:N),'b');
title(['滤波器阶数 = ',num2str(filter_order),',delta =',num2str(delta),'时的重建信号yre与原始信号x1的对比（局部）']);

figure(3);

plot(99880:N,error(99880:N),'r');
hold on;plot((99880:N),x2(99880:N),'b');
title(['滤波器阶数 = ',num2str(filter_order),',delta =',num2str(delta),'时的滤波器误差与噪声信号x2的对比（局部）']);
