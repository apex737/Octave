clc;clear;close all;
v = [1;2];

k_values = linspace(0, 2, 50);

figure;
hold on;
grid on;
axis equal;

xlim([-5 5]);
ylim([-5 5]);

for i = 1:length(k_values)
    k = k_values(i);
    v_scaled = k * v;
    clf;  % 현재 Figure를 지우고 새로 그리기 (Clear Figure)
    hold on;
    grid on;
    axis equal;
    xlim([-5 5]);
    ylim([-5 5]);
    plot([0 v_scaled(1)], [0 v_scaled(2)], 'b-', 'LineWidth', 2);
    plot(v_scaled(1), v_scaled(2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    title(['Scaling Factor k = ', num2str(k)]);
    pause(0.05);  % 잠시 멈춤 (0.1초)
end