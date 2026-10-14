clc;clear;close all;

figure;
axis equal;
hold on;
grid on;

theta = linspace(0, 2*pi, 100);
x = cos(theta);
y = sin(theta);
A = [2 -1; 1 3];

transformed_points = A * [x; y];

% (1, :) -> 행렬의 첫 번째 행을 선택하여 x 좌표를 가져옵니다.
% (2, :) -> 행렬의 두 번째 행을 선택하여 y 좌표를 가져옵니다.
x_transformed = transformed_points(1, :); 
y_transformed = transformed_points(2, :); 

plot(x, y, 'b-', 'LineWidth', 2);
plot(x_transformed, y_transformed, 'r--', 'LineWidth', 2);