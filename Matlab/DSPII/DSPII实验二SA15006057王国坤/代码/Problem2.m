%% �����źŲ������ֵ
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
title('�źŵ�����غ���');

%% ����������ǿ
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
title(['�˲������� = ',num2str(filter_order),',delta =',num2str(delta),'ʱ���ؽ��ź�yre��ԭʼ�ź�x1�ĶԱȣ��ֲ���']);

figure(3);

plot(99880:N,error(99880:N),'r');
hold on;plot((99880:N),x2(99880:N),'b');
title(['�˲������� = ',num2str(filter_order),',delta =',num2str(delta),'ʱ���˲�������������ź�x2�ĶԱȣ��ֲ���']);
