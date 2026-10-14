clc;clear;close all;


figure;

x_point = [1 -1];
y_point = [1 -1];

h = plot(x_point(1), y_point(1), 'ro', 'MarkerSize', 10, ...
    'MarkerFaceColor', 'r');

axis equal;
grid on;
xlim([-2, 2]);
ylim([-2, 2]);
set(gca, 'FontSize', 12);

text(x_point(1)+0.1, y_point(1), '(1,1)', 'FontSize', 12, 'Color', 'g');
