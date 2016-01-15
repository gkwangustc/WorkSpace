%% figure 4 SNR && p-value
% Guokun Wang
% SA15006057
% gkwang@mail.ustc.edu.cn

figure(4);
hold on;
% N_n = [50000 10000 5000];
% percent_n = [0.05 0.01 0.005];
SNR_n = 0:1:25;

tmp1 = mean(record1(:,:,:,:),4);
% 10000 5% Swerling 0
tmp = tmp1(1,1,:);
plot(SNR_n, tmp(:), 'bo-');
% 10000 1% Swerling 0
tmp = tmp1(1,2,:);
plot(SNR_n, tmp(:), 'b*-');
% 10000 0.5% Swerling 0
tmp = tmp1(1,3,:);
plot(SNR_n, tmp(:), 'bx-');

SNR_n = 0:1:25;
tmp2 = mean(record2(:,:,:,:),4);
% 10000 5% Swerling 1
tmp = tmp2(1,1,:);
plot(SNR_n, tmp(:), 'ro-');
% 10000 1% Swerling 1
tmp = tmp2(1,2,:);
plot(SNR_n, tmp(:), 'r*-');
% 10000 0.5% Swerling 1
tmp = tmp2(1,3,:);
plot(SNR_n, tmp(:), 'rx-');
title('目标信号出现的比例对KS拟合优度检验的影响')
legend('Swerling 0 5%','Swerling 0 1%','Swerling 0 0.5%','Swerling 1 5%','Swerling 1 1%','Swerling 1 0.5%')
xlabel('SNR(dB)');
ylabel('p-value');
%% figure 5

figure(5);
hold on;
% N_n = [50000 10000 5000];
% percent_n = [0.05 0.01 0.005];
SNR_n = 0:1:25;

tmp3 = mean(record3(:,:,:,:),4);
% 50000 1% Swerling 0
tmp = tmp3(1,1,:);
plot(SNR_n, tmp(:), 'bo-');
% 10000 1% Swerling 0
tmp = tmp3(2,1,:);
plot(SNR_n, tmp(:), 'b*-');
% 5000 1% Swerling 0
tmp = tmp3(3,1,:);
plot(SNR_n, tmp(:), 'bx-');

SNR_n = 0:1:25;
tmp4 = mean(record4(:,:,:,:),4);
% 50000 1% Swerling 1
tmp = tmp4(1,1,:);
plot(SNR_n, tmp(:), 'ro-');
% 10000 1% Swerling 1
tmp = tmp4(2,1,:);
plot(SNR_n, tmp(:), 'r*-');
% 5000 1% Swerling 1
tmp = tmp4(3,1,:);
plot(SNR_n, tmp(:), 'rx-');
title('采样样本数量变化的影响')
legend('Swerling 0 50000','Swerling 0 10000','Swerling 0 5000','Swerling 1 50000','Swerling 1 10000','Swerling 1 5000')
xlabel('SNR(dB)');
ylabel('p-value');