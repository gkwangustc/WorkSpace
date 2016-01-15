%%GPD Fit && Emprical CDF
% Guokun Wang
% SA15006057
% gkwang@mail.ustc.edu.cn

clc;
clear all;

SNR = 13; %dB
% 13dB (which is the point where Pd is 0.9 for a Pfa of 1E-6 )

A = sqrt(2*10^(SNR/10)); % SNR = A^2/2;

pd_h0 = makedist('Rayleigh','b',1);
pd_h1 = makedist('Rician','s',A,'sigma',1);

x0 = random(pd_h0,[9900 1]);
x1 = random(pd_h1,[100 1]);

% 打乱顺序组合起来，作为观测数据
x = [x0;x1];
len_x = length(x);
N = len_x;
x = x(randperm(len_x));


%% 提取top %10 拟合 GPD
sorted_x = sort(x,'descend');
top_10percent = sorted_x(1:(floor(len_x*0.1)));
n = length(top_10percent);
u = max(sorted_x((floor(len_x*0.1)+1):end));
top_10percent = top_10percent-u;

[parmhat,parmci] = gpfit(top_10percent);

%% show figure 1
x_0 = u:0.1:8.3;
figure(1);
P = gpcdf(x_0,parmhat(1),parmhat(2),u);
semilogy(x_0,n/N*(1-P),'b');
grid on;
hold on;
P = gpcdf(x_0,parmci(1,1),parmci(1,2),u);
semilogy(x_0,n/N*(1-P),'r--');
P = gpcdf(x_0,parmci(2,1),parmci(2,2),u);
semilogy(x_0,n/N*(1-P),'r--');

y_0 = cumsum(histc(top_10percent,[0,x_0(1:end-1)-u]))'/n;
y_0 = n/N*(1-y_0);

semilogy(x_0,y_0,'mo-');
axis([2 9 1E-4 10^(-0.5)]);
title('未去除目标信号前的经验分布、GPD拟合分布、90%置信概率界')
legend('GPD Fit','90% Confidence','90% Confidence','Empricial CDF')
xlabel('X');
ylabel('1-F(X)');
%% KS test
alpha = 0.1;
x_0 = u:0.1:10;
nn = 200;
D = zeros(1,nn);
p = zeros(1,nn);
lamda = zeros(1,nn);
for i = 1:nn
    Y = top_10percent(i:end);
    tmp_n = length(Y);
    [parmhat,~] = gpfit(Y);
    G = gpcdf(x_0,parmhat(1),parmhat(2),u);
    y_0 = cumsum(histc(Y,[0,x_0(1:end-1)-u]))'/tmp_n;
    D(i) = max(abs(G-y_0));
    lamda(i) = sqrt(tmp_n)*D(i);
    k = 1:1000;
    p(i) = 1-2*sum((-1).^(k-1).*exp(-2*k.^2*(lamda(i))^2));
end

%target_i = find(diff(sign(diff(D))),1)+1;
target_i = find(D==min(D));
new_x = top_10percent((target_i+1):end);
new_n = length(new_x);
%% show figure 2
figure(2);
plot(D(1:nn));
title('D(n,i)')
xlabel('i');
ylabel('D(n,i)');
%% 重新拟合 GPD
[parmhat,parmci] = gpfit(new_x);

%% show figure 3
x_0 = u:0.1:3.9;
figure(3);
P = gpcdf(x_0,parmhat(1),parmhat(2),u);
semilogy(x_0,new_n/N*(1-P),'b');
grid on;
hold on;
P = gpcdf(x_0,parmci(1,1),parmci(1,2),u);
semilogy(x_0,n/N*(1-P),'r--');
P = gpcdf(x_0,parmci(2,1),parmci(2,2),u);
semilogy(x_0,n/N*(1-P),'r--');

y_0 = cumsum(histc(new_x,[0,x_0(1:end-1)-u]))'/new_n;
y_0 = new_n/N*(1-y_0);

semilogy(x_0,y_0,'mo-');
axis([2 4 10^(-4.5) 10^(-0.5)]);
title('去除目标信号后的经验分布、GPD拟合分布、90%置信概率界')
legend('GPD Fit','90% Confidence','90% Confidence','Empricial CDF')
xlabel('X');
ylabel('1-F(X)');