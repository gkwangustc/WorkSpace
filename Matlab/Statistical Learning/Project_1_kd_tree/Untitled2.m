N = 12;
n = 1:1:N;
X =sin(n*pi/2);
Y = zeros(1,N);
Y(1) = 1;
Y(2) = 1;

for i = 3:1:N-1
    Y(i) = X(i) + X(i - 1) + 0.5 * X(i - 2);
end
a = zeros(N,2);
a(1,:) = [0.1,0];
a(2,:) = [0.1,0.1];
for i = 2:1:10
    e = Y(i+1) - a(i,:)*[X(i+1);X(i)];
    a(i+1,:) = a(i,:)+0.1*e*[X(i+1),X(i)];
end