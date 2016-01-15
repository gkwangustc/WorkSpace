x = [3,4,1;3,3,1];
y = [1,1,-1];
w = [1;1];
figure(1);
Is_All_Right = false;
bias = 0;
while ~Is_All_Right
    for i = 1 : length(y)
        if y(i)* w'* x(:,i) <= 0
            w = w +  y(i) * x(:,i);
            bias = bias +  y(i);
            break;
        end        
    end
    if sign(y .* (w' * x + repmat(bias, 1, length(y)))) == ones(1, length(y))
        Is_All_Right = true;
    end
end
figure(1);
x_positive = find(y==1);
x_negative = find(y==-1);
plot(x(1,x_positive),x(2,x_positive),'o'); hold on;
plot(x(1,x_negative),x(2,x_negative),'*'); 
h = ezplot(sprintf('%f * x_0 + %f * x_1 + %f',w(1),w(2),bias));
set(h,'color','r');
axis([0,6,0,6])

[height,width] = size(x);
alpha = zeros(width,1); b_dual = 0; eta_dual = 1;
Is_all_right_dual = false;
Gram_martix = zeros(width);
for i = 1 : width
    for j = 1 : width
        Gram_martix(i,j) = x(:,i)' * x(:,j);
    end
end

while ~Is_all_right_dual
    for i = 1 : width
        if y(i) * (alpha' .* y * Gram_martix(:,i) + b_dual) <= 0
            alpha(i) = alpha(i) + eta_dual;
            b_dual = b_dual + eta_dual * y(i);
            break;
        end        
    end
    if sign(y .* (alpha' .* y * Gram_martix + repmat(b_dual, 1, width))) == ones(1, width)
        Is_all_right_dual = true;
    end    
end
w_dual = sum(repmat(alpha'.*y,height,1).* x,2);
h = ezplot(sprintf('%f * x_0 + %f * x_1 + %f',w_dual(1),w_dual(2),b_dual));
set(h,'color','b');
legend('Positive data','Negative data','Original','Dual form');
hold off;
title('The results of Perceptron');


