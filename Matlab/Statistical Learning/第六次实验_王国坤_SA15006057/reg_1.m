clc
clear all;

Models = 100;
level = 3;
m_c1 = zeros(level+1, Models);
m_c2 = zeros(level+1, Models);
m_threshold = zeros(1, Models);
N = 25;
alpha = 0.5;


for m = 1:Models
    x = [0, rand(1, N), 1];
    x = sort(x);
%     feature_x = [ones(1, N); x; x.^2; x.^3];
    y = sin(2 * pi * x) + alpha * randn(1, length(x));
    min_error = inf;
    min_c1 = zeros(4, 1);
    min_c2 = zeros(4, 1);
    threshold = 0;
    for i = (level+2):(N-level-2)
        x1 = x(:, 1:i);
        x2 = x(:, i+1:end);
        y1 = y(:, 1:i);
        y2 = y(:, i+1:end);

        c1 = polyfit(x1,y1,level);
        c2 = polyfit(x2,y2,level);
%         c1 = pinv(feature1') * value1';
%         c2 = pinv(feature2') * value2';
        error = norm(polyval(c1, x1) - y1)^2 + norm(polyval(c2, x2) - y2)^2;
%         error = norm(c1' * feature1 - value1)^2 + norm(c2' * feature2 - value2)^2;
        if error < min_error
            min_error = error;
            min_c1 = c1;
            min_c2 = c2;
            threshold = 0.5 * (x(i) + x(i + 1));
        end
    end
    m_c1(:, m) = min_c1;
    m_c2(:, m) = min_c2;
    m_threshold(:, m) = threshold;
end


%%
plot_x = 0:0.01:1;
% plot_xx = [ones(1, length(plot_x)); plot_x; plot_x.^2; plot_x.^3];
plot_y = sin(2 * pi * plot_x);
reg_y = zeros(size(plot_y));
count = 0;
for m = 1:Models
    if max(abs([m_c1(:, m);m_c2(:, m)])) < 1E3
        reg_y = reg_y + (plot_x < m_threshold(:, m)) .* polyval(m_c1(:, m), plot_x) ...
            + (plot_x >= m_threshold(:, m)) .* polyval(m_c2(:, m), plot_x);
        count = count + 1;
    end
end
reg_y = reg_y / count;
% norm(reg_y - plot_y)/length(plot_x)
figure(1);
hold on;
plot(plot_x, plot_y, 'b');
plot(plot_x, reg_y, 'r');

