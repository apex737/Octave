clc;clear;close all;
% 궤도와 움직이는 원의 크기, 회전 속도 설정
radius = 1.0;        % 파란 점선 궤도의 반지름
red_radius = 0.12;   % 빨간 원의 반지름
orbit_period = 4.0;  % 한 바퀴 도는 시간 (초)

fig = figure;
hold on;
grid on;
axis equal;
view_limit = radius + red_radius + 0.2;
xlim([-view_limit, view_limit]);
ylim([-view_limit, view_limit]);

theta = linspace(0, 2*pi, 200);
plot(radius * cos(theta), radius * sin(theta), 'b--', 'LineWidth', 2);

% 빨간 원의 중심은 (radius, 0)에서 출발
disk_x = red_radius * cos(theta);
disk_y = red_radius * sin(theta);
ball = fill(radius + disk_x, disk_y, 'r', 'EdgeColor', 'none');
title('Close the figure to stop');

% 경과 시간으로 위치를 계산하고, 창을 닫으면 종료
timer_id = tic;
while ishandle(fig)
    angle = 2*pi * toc(timer_id) / orbit_period;
    center_x = radius * cos(angle);
    center_y = radius * sin(angle);

    set(ball, 'XData', center_x + disk_x, 'YData', center_y + disk_y);
    drawnow;
    pause(0.02);
end