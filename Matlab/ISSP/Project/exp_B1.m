%% 算 p 和 SNR 的，保存到 record 1 2 3 4 里了， 画图用 exp_B2.m
% Guokun Wang
% SA15006057
% gkwang@mail.ustc.edu.cn

clc;
clear all;
warning off all;
%%
% Swerling 0
%%
N_n = [10000];
percent_n = [0.05 0.01 0.005];
%%%%%%%%%%%%%%%%%%%
SNR_n = 0:1:25;

rep = 10000;

record1 = zeros(length(N_n),length(percent_n),length(SNR_n),rep);
for mm = 1:rep
    disp(mm);
for kk = 1:length(SNR_n)
    SNR = SNR_n(kk);
    A = sqrt(2*10^(SNR/10)); % SNR = A^2/2;
    pd_h0 = makedist('Rayleigh','b',1);
    pd_h1 = makedist('Rician','s',A,'sigma',1);
for ii = 1:length(N_n)
for jj = 1:length(percent_n)
    
    percent = percent_n(jj);
    N = N_n(ii);

    x0 = random(pd_h0,[(N-floor(N*percent))  1]);
    x1 = random(pd_h1,[floor(N*percent) 1]);

    % 打乱顺序组合起来，作为观测数据
    x = [x0;x1];
    len_x = length(x);
%     x = x(randperm(len_x));


    %% 提取top %10 拟合 GPD
    sorted_x = sort(x,'descend');
    top_10percent = sorted_x(1:(floor(len_x*0.1)));
    n = length(top_10percent);
    u = max(sorted_x((floor(len_x*0.1)+1):end));
    top_10percent = top_10percent-u;

    %% KS test
%     alpha = 0.1;
    x_0 = u:0.5:10;
    [parmhat,~] = gpfit(top_10percent);
    G = gpcdf(x_0,parmhat(1),parmhat(2),u);
    y_0 = cumsum(histc(top_10percent,[0,x_0(1:end-1)-u]))'/n;
    D = max(abs(G-y_0));
    lamda = sqrt(n)*D;
    k = 1:500;
    p = 2*sum((-1).^(k-1).*exp(-2*k.^2*(lamda)^2));
    record1(ii,jj,kk,mm) = p;

end
end
end
end

%%
% Swerling I
%%
record2 = zeros(length(N_n),length(percent_n),length(SNR_n),rep);
for mm = 1:rep
    disp(mm);
for kk = 1:length(SNR_n)
    SNR = SNR_n(kk);
    q = 10^(SNR/10);
    k = 1.16;
    pd_h0 = makedist('Weibull','a',sqrt(2),'b',k);
    pd_h1 = makedist('Rician','s',0,'sigma',sqrt(1+q));
for ii = 1:length(N_n)
for jj = 1:length(percent_n)

    percent = percent_n(jj);
    N = N_n(ii);
    x0 = random(pd_h0,[(N-floor(N*percent))  1]);
    x1 = random(pd_h1,[floor(N*percent) 1]);

    % 打乱顺序组合起来，作为观测数据
    x = [x0;x1];
    len_x = length(x);
%     x = x(randperm(len_x));


    %% 提取top %10 拟合 GPD
    sorted_x = sort(x,'descend');
    top_10percent = sorted_x(1:(floor(len_x*0.1)));
    n = length(top_10percent);
    u = max(sorted_x((floor(len_x*0.1)+1):end));
    top_10percent = top_10percent-u;

    %% KS test
%     alpha = 0.1;
    x_0 = u:0.5:10;
    [parmhat,~] = gpfit(top_10percent);
    G = gpcdf(x_0,parmhat(1),parmhat(2),u);
    y_0 = cumsum(histc(top_10percent,[0,x_0(1:end-1)-u]))'/n;
    D = max(abs(G-y_0));
    lamda_2 = n*D*D;
    k = 1:500;
    p = 2*sum((-1).^(k-1).*exp(-2*k.^2*lamda_2));
    record2(ii,jj,kk,mm) = p;

end
end
end
end

%%
% Swerling 0
%%
N_n = [50000 10000 5000];
percent_n = [0.01];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

record3 = zeros(length(N_n),length(percent_n),length(SNR_n),rep);
for mm = 1:rep
    disp(mm);
for kk = 1:length(SNR_n)
    SNR = SNR_n(kk);
    A = sqrt(2*10^(SNR/10)); % SNR = A^2/2;
    pd_h0 = makedist('Rayleigh','b',1);
    pd_h1 = makedist('Rician','s',A,'sigma',1);
for ii = 1:length(N_n)
for jj = 1:length(percent_n)
    
    percent = percent_n(jj);
    N = N_n(ii);

    x0 = random(pd_h0,[(N-floor(N*percent))  1]);
    x1 = random(pd_h1,[floor(N*percent) 1]);

    % 打乱顺序组合起来，作为观测数据
    x = [x0;x1];
    len_x = length(x);
%     x = x(randperm(len_x));


    %% 提取top %10 拟合 GPD
    sorted_x = sort(x,'descend');
    top_10percent = sorted_x(1:(floor(len_x*0.1)));
    n = length(top_10percent);
    u = max(sorted_x((floor(len_x*0.1)+1):end));
    top_10percent = top_10percent-u;

    %% KS test
%     alpha = 0.1;
    x_0 = u:0.5:10;
    [parmhat,~] = gpfit(top_10percent);
    G = gpcdf(x_0,parmhat(1),parmhat(2),u);
    y_0 = cumsum(histc(top_10percent,[0,x_0(1:end-1)-u]))'/n;
    D = max(abs(G-y_0));
    lamda = sqrt(n)*D;
    k = 1:500;
    p = 2*sum((-1).^(k-1).*exp(-2*k.^2*(lamda)^2));
    record3(ii,jj,kk,mm) = p;

end
end
end
end

%%
% Swerling I
%%
record4 = zeros(length(N_n),length(percent_n),length(SNR_n),rep);
for mm = 1:rep
    disp(mm);
for kk = 1:length(SNR_n)
    SNR = SNR_n(kk);
    q = 10^(SNR/10);
    k = 1.16;
    pd_h0 = makedist('Weibull','a',sqrt(2),'b',k);
    pd_h1 = makedist('Rician','s',0,'sigma',sqrt(1+q));
for ii = 1:length(N_n)
for jj = 1:length(percent_n)

    percent = percent_n(jj);
    N = N_n(ii);
    x0 = random(pd_h0,[(N-floor(N*percent))  1]);
    x1 = random(pd_h1,[floor(N*percent) 1]);

    % 打乱顺序组合起来，作为观测数据
    x = [x0;x1];
    len_x = length(x);
%     x = x(randperm(len_x));


    %% 提取top %10 拟合 GPD
    sorted_x = sort(x,'descend');
    top_10percent = sorted_x(1:(floor(len_x*0.1)));
    n = length(top_10percent);
    u = max(sorted_x((floor(len_x*0.1)+1):end));
    top_10percent = top_10percent-u;

    %% KS test
%     alpha = 0.1;
    x_0 = u:0.5:10;
    [parmhat,~] = gpfit(top_10percent);
    G = gpcdf(x_0,parmhat(1),parmhat(2),u);
    y_0 = cumsum(histc(top_10percent,[0,x_0(1:end-1)-u]))'/n;
    D = max(abs(G-y_0));
    lamda_2 = n*D*D;
    k = 1:500;
    p = 2*sum((-1).^(k-1).*exp(-2*k.^2*lamda_2));
    record4(ii,jj,kk,mm) = p;

end
end
end
end

warning('on','all');
warning('query','all');