clc;clear;close all;

u =  [1;2];
v =  [3;1];

% 0부터 1까지 담긴 20개의 값으로 이루어진 벡터 생성
a = linspace(0, 1, 20); 
b = linspace(0, 1, 20);

figure;
hold on;
grid on;
axis equal;

for i = 1:length(a)
    for j = 1:length(b)
        point = a(i) * u + b(j) * v;
        plot(point(1), point(2), 'bo');
    endfor
end