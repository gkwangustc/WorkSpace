%% DSPII��һ��ʵ�����
% ����С��Ĵ���д��һ��.m�ļ��У�һ�����м��ɻ������ͼ��
% ���ߣ������� SA15006057 gkwang@mail.ustc.edu.cn

%% 1) ����MATLAB���������������������������ĵ�ֵ����
% Ϊ��֤��ͼЧ����h0,h1��ȡֵ����ϴ�Ϊ0.1
% �����������Ϊfigure(1), �����������ĵ�ֵ����Ϊfigure(2)

h_0 = (-2:0.1:4);
h_1 = (-4:0.1:2);

%vΪ��ֵ������
v=0:0.1:2;
h_conv = ones(1,length(h_0));

% J_N�Ĺ�ʽ����PPT�õ���
J_N = 0.55 + (h_0.*h_0)'*h_conv + h_conv'*h_1.^2 + 2*h_0'*h_1*cos(pi/8.0) -  sqrt(2)*h_0'*h_conv*cos(pi/10.0) - sqrt(2)*h_conv'*h_1*cos(9*pi/40.0);

figure(1)
surf(h_0,h_1,J_N);
title('�����������');
xlabel('h0');
ylabel('h1');

figure(2)
contour(h_0,h_1,J_N,v);
title('�����������ĵ�ֵ����');
xlabel('h0');
ylabel('h1');

%% 3) ��MATLAB��������Ϊ0.05,��ֵΪ0������S(n)������������һ��ʵ�ֵĲ���ͼ
% ȡN = 500������ʵ�鶼���������ֵ��S(n)ͨ��randn����������randn��ֵΪ0������Ϊ1������Ҫ����sqrt(0.05)
% ����Ϊfigure(3)

N = 500;
n = 1:1:N;
S = sqrt(0.05)*randn(1,N);

figure(3)
plot(S);
title('����S(n)�Ĳ���ͼ');
xlabel('n');
ylabel('S(n)');

%% 4)�������������ĵ�ֵ�����ϵ��ӻ���������½����� LMS��ʱH(n)���ڵ��������еĹ켣���ߡ�
%��½����õ��Ľ��ΪH��LMS�㷨�õ��Ľ��ΪH_LMS
%���õ���ͼ��Ϊfigure(4)

H = zeros(2,N);
e = zeros(100,N);
J = zeros(100,N);
H_LMS = zeros(2,N);
H_SUM = zeros(2,N);
V = zeros(2,N);
N_0 = sin(2*pi*n/16.0 + pi/10.0);
N_1 = sqrt(2)*sin(2*pi*n/16.0);
R_xx = [1,cos(pi/8.0);cos(pi/8.0),1];
r_yx = [cos(pi/10)/sqrt(2);cos(pi/10+pi/8)/sqrt(2)];
H(:,1) = [3;-4];
H_LMS(:,1) = [3;-4];

for i=2:1:N
    V(:,i) = 2*R_xx*H(:,i-1)-2*r_yx;
    H(:,i) = H(:,i-1) - 0.5*0.4*V(:,i);
end

for i=2:1:N
    e(1,i) = S(i)+N_0(i)-H_LMS(:,i-1)'*[N_1(i);N_1(i-1)];
    J(1,i) = e(1,i)^2;
    H_LMS(:,i) = H_LMS(:,i-1) + 0.4*e(1,i)*[N_1(i);N_1(i-1)];
end

figure(4)
plot(H_LMS(1,:),H_LMS(2,:));
hold on;
plot(H(1,:),H(2,:));
hold on;
contour(h_0,h_1,J_N,v);
title('��½�����LMS��ʱH(n)�Ĺ켣����');
legend('LMS�㷨���ι켣','��½����켣','��ֵ����');
xlabel('h0');
ylabel('h1');

%% 5)����һ�ε�J(n)��e(n)�������100��J(n)��ƽ��ֵ
%��Ϊ5)��6)��Ҫ�õ�100��LMS�㷨�Ľ������������������100��LMS�㷨������J(n),e(n)��100�ν���洢������LMS�㷨�Ľ���ۼӵ�H_SUM�У�������100�õ���ֵ
%5)�õ���ͼ��Ϊfigure(5)�����о�ֵ��mean(J)�õ�

for j=1:1:100
    S = sqrt(0.05)*randn(1,N);
    for i=2:1:N
        e(j,i) = S(i)+N_0(i)-H_LMS(:,i-1)'*[N_1(i);N_1(i-1)];
        J(j,i) = e(j,i)^2;
        H_LMS(:,i) = H_LMS(:,i-1) + 0.4*e(j,i)*[N_1(i);N_1(i-1)];
    end
    H_SUM = H_SUM+H_LMS;
end

figure(5)

subplot(3,1,1)
plot(e(1,:));
title('LMS�㷨����ʵ����e(n)');
xlabel('n');
ylabel('e(n)');

subplot(3,1,2)
plot(J(1,:));
title('LMS�㷨����ʵ����J(n)');
xlabel('n');
ylabel('J(n)');

subplot(3,1,3)
plot(mean(J));
title('LMS�㷨100��ʵ����ƽ��J(n)');
xlabel('n');
ylabel('J(n)');

%% 6)�������������ĵ�ֵ�����ϵ��ӻ���LMS��ʱ100��ʵ���е�H(n)��ƽ��ֵ�Ĺ켣���ߣ�
%��5)���Ѿ�ͨ����100��LMS�㷨�Ľ���ۼӵõ���H_SUM��������100���ɵõ���ֵ
%6)�õ���ͼ��Ϊfigure(6)

figure(6)
plot(H_SUM(1,:)/100.0,H_SUM(2,:)/100.0);
hold on;
plot(H(1,:),H(2,:));
hold on;
contour(h_0,h_1,J_N,v);
title('��½�����LMS�㷨100��ͳ��ƽ���켣����');
xlabel('h0');
ylabel('h1');
legend('LMS�㷨100��ƽ���켣','��½����켣','��ֵ����');