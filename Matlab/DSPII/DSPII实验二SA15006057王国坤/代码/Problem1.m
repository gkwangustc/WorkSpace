close all;
%% ��ô��������������ź�����
% Guokun Wang SA15006057
% gkwang@mail.ustc.edu.cn
N = 1000; % �źŵĳ���
N_time = 100;
a1 = 0.1;
a2 = -0.8;
var = 0.27;
x = zeros(N_time,N);
white_noise = wgn(N_time,N,10 * log10(var));
x(:,1) = white_noise(:,1);
x(:,2) = -a1 * x(:,1) + white_noise(:,2);
for i = 3:N
    x(:,i) = -a1 * x(:,i - 1) - a2*x(:,i-2) + white_noise(:,i);
end
% plot(x);

%% LMS
iteration_num = N;
delta = 0.05;
H = zeros(2,1);
% error_it = zeros(N_time,iteration_num);
error_this_iteration = zeros(N_time,iteration_num);
error_record = zeros(1,iteration_num);
H_record = zeros(2,iteration_num);
for j = 1:N_time
    H = zeros(2,1);
    for i = 2:iteration_num - 1
        error_this_iteration(j,i + 1)=x(j,i + 1)-(H(1) * x(j,i) + H(2) * x(j,i - 1));
        H(1) = H(1) + delta*error_this_iteration(j,i + 1) * x(j,i);
        H(2) = H(2) + delta*error_this_iteration(j,i + 1) * x(j,i - 1);
        H_record(:,i + 1) = H_record(:,i + 1) + H;
    end
end
H_record = H_record / N_time;

plot(1:iteration_num,H_record(1,:),'r');
hold on;
plot(1:iteration_num,H_record(2,:),'b');
grid on;
title(['a1��a2�ĵ���ͼ,N=',num2str(N),',delta=',num2str(delta)]);legend('a1','a2');

%% ����ʱ�䳣��
rx = [1,-0.5];
R_xx = toeplitz(rx);
eigen_value = eig(R_xx); %�������ֵ
t_c = 1./(eigen_value.*delta);

%% ����error�Ĺ�����
figure(2);
plot((0:iteration_num - 1) / iteration_num,10 * log10(abs(fft(mean(error_this_iteration)).^2) / iteration_num));
title('Ԥ���������ܶ�ͼ');
figure(3);
subplot(1,2,1);
plot((0:iteration_num - 1) / iteration_num,10 * log10(abs(fft(- a1 - H_record(1,:)).^2) / iteration_num),'b');
title('a1�������ܶ�ͼ');
subplot(1,2,2);
plot((0:iteration_num - 1) / iteration_num,10 * log10(abs(fft(- a1 - H_record(1,:)).^2) / iteration_num),'b');
title('a2�������ܶ�ͼ');


%% ���������������
Jmin=0.27;
Jth = zeros(1,iteration_num);
alpha = [-0.2;0.4];
for i = 1:iteration_num
    Jth(i) = Jmin + eigen_value' * alpha;
    alpha = (eye(2) - 2 * delta * diag(eigen_value) + delta^2 * eigen_value * eigen_value') * alpha + (delta.^2 * Jmin * eigen_value);
end
error_ave = mean(error_this_iteration.^2);

figure;
plot(1:N,Jth,'r');
hold on;
plot(3:N,error_ave(3:N),'b');
title('�����������������ʵ����������');
legend('��������','ʵ������');


