clc; clear; close all;

% 작업공간
L1 = 4; L2 = 2;
theta1_vals = linspace(0, 2 * pi, 100);
theta2_vals = linspace(0, 2 * pi, 100);

figure; hold on; axis equal;

xlabel('X');
ylabel('Y');
title('2DOF Robot WorkSpace');
axis([-6 6 -6 6]);
grid on;

h_robot = plot([0, 0], [0, 0], 'r-', 'linewidth', 2);
h_workspace = plot(0, 0, 'b.');

x_vals = [];
y_vals = [];

for theta1 = theta1_vals

    for theta2 = theta2_vals
        x1 = L1 * cos(theta1);
        y1 = L1 * sin(theta1);
        x2 = x1 + L2 * cos(theta1 + theta2);
        y2 = y1 + L2 * sin(theta1 + theta2);

        set(h_robot, 'XData', [0 x1 x2], 'YData', [0 y1 y2]);

        x_vals = [x_vals, x2];
        y_vals = [y_vals, y2];

        set(h_workspace, 'XData', x_vals, 'YData', y_vals);
        drawnow;
        pause(0.01);
    endfor

end
