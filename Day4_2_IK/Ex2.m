clc; clear; close all;
L1 = 4; L2 = 2;
theta1_vals = linspace(0, 2 * pi, 100);
theta2_vals = linspace(0, 2 * pi, 100);

figure; hold on; axis equal;

xlabel('X');
ylabel('Y');
title('2DOF Robot WorkSpace');
axis([-6 6 -6 6]);
grid on;

x_vals = [];
y_vals = [];

for theta1 = theta1_vals

    for theta2 = theta2_vals
        x = L1 * cos(theta1) + L2 * cos(theta1 + theta2);
        y = L1 * sin(theta1) + L2 * sin(theta1 + theta2);

        x_vals = [x_vals, x];
        y_vals = [y_vals, y];
    endfor

end

plot(x_vals, y_vals, 'b.');
drawnow;
