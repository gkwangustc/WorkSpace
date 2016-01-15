%% DSPII第一次实验代码
% 几个小题的代码写在一个.m文件中，一次运行即可获得所有图像
% 作者：王国坤 SA15006057 gkwang@mail.ustc.edu.cn

%% 1) 借助MATLAB画出误差性能曲面和误差性能曲面的等值曲线
% 为保证作图效果，h0,h1的取值间隔较大，为0.1
% 误差性能曲面为figure(1), 误差性能曲面的等值曲线为figure(2)

h_0 = (-2:0.1:4);
h_1 = (-4:0.1:2);

%v为等值线向量
v=0:0.1:2;
h_conv = ones(1,length(h_0));

% J_N的公式是由PPT得到的
J_N = 0.55 + (h_0.*h_0)'*h_conv + h_conv'*h_1.^2 + 2*h_0'*h_1*cos(pi/8.0) -  sqrt(2)*h_0'*h_conv*cos(pi/10.0) - sqrt(2)*h_conv'*h_1*cos(9*pi/40.0);

figure(1)
surf(h_0,h_1,J_N);
title('误差性能曲面');
xlabel('h0');
ylabel('h1');

figure(2)
contour(h_0,h_1,J_N,v);
title('误差性能曲面的等值曲线');
xlabel('h0');
ylabel('h1');

%% 3) 用MATLAB产生方差为0.05,均值为0白噪音S(n)，并画出其中一次实现的波形图
% 取N = 500，后续实验都采用这个数值，S(n)通过randn产生，由于randn均值为0，方差为1，故需要乘以sqrt(0.05)
% 噪音为figure(3)

N = 500;
n = 1:1:N;
S = sqrt(0.05)*randn(1,N);

figure(3)
plot(S);
title('噪音S(n)的波形图');
xlabel('n');
ylabel('S(n)');

%% 4)在误差性能曲面的等值曲线上叠加画出采用最陡下降法， LMS法时H(n)的在叠代过程中的轨迹曲线。
%最陡下降法得到的结果为H，LMS算法得到的结果为H_LMS
%最后得到的图像为figure(4)

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
title('最陡下降法与LMS法时H(n)的轨迹曲线');
legend('LMS算法单次轨迹','最陡下降法轨迹','等值曲线');
xlabel('h0');
ylabel('h1');

%% 5)画出一次的J(n)及e(n)，并求出100次J(n)的平均值
%因为5)及6)都要用到100次LMS算法的结果，所以在这里做了100次LMS算法，并将J(n),e(n)的100次结果存储起来，LMS算法的结果累加到H_SUM中，最后除以100得到均值
%5)得到的图像为figure(5)，其中均值由mean(J)得到

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
title('LMS算法单次实现下e(n)');
xlabel('n');
ylabel('e(n)');

subplot(3,1,2)
plot(J(1,:));
title('LMS算法单次实现下J(n)');
xlabel('n');
ylabel('J(n)');

subplot(3,1,3)
plot(mean(J));
title('LMS算法100次实现下平均J(n)');
xlabel('n');
ylabel('J(n)');

%% 6)在误差性能曲面的等值曲线上叠加画出LMS法时100次实验中的H(n)的平均值的轨迹曲线；
%在5)中已经通过将100次LMS算法的结果累加得到到H_SUM，最后除以100即可得到均值
%6)得到的图像为figure(6)

figure(6)
plot(H_SUM(1,:)/100.0,H_SUM(2,:)/100.0);
hold on;
plot(H(1,:),H(2,:));
hold on;
contour(h_0,h_1,J_N,v);
title('最陡下降法及LMS算法100次统计平均轨迹曲线');
xlabel('h0');
ylabel('h1');
legend('LMS算法100次平均轨迹','最陡下降法轨迹','等值曲线');