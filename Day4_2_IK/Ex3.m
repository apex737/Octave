% FK
clc; clear;

function [x, y] = FK(theta1, theta2, L1, L2)
    x = L1 * cos(theta1) + L2 * cos(theta1 + theta2);
    y = L1 * sin(theta1) + L2 * sin(theta1 + theta2);
endfunction

[x, y] = FK(pi / 6, pi / 6, 1, 1)

% IK
function [theta1, theta2] = IK(x, y, L1, L2)
    c2 = (x^2 + y^2 - L1^2 - L2^2) / (2 * L1 * L2);
    s2 = sqrt(1 - c2^2);
    theta2 = atan2(s2, c2);
    detA = det([L1 + L2 * c2, -L2 * s2; L2 * s2, L1 + L2 * c2]);
    detB = det([x, -L2 * s2; y, L1 + L2 * c2]);
    detC = det([L1 + L2 * c2, x; L2 * s2, y]);
    c1 = detB / detA;
    s1 = detC / detA;
    theta1 = atan2(s1, c1);
endfunction

% SIM
function twoDofRobotIK_Sim()
    L1 = 1.0;
    L2 = 1.0;

    % Motinon Planning
    t = linspace(0, 2 * pi, 100);
    x = 1 + 0.5 * cos(t);
    y = 0.5 + 0.5 * sin(t);
    axis([-2 2 -2 2]);
    hold on; grid on;

    for i = 1:length(t)
        target_x = x(i);
        target_y = y(i);
        [theta1, theta2] = IK(target_x, target_y, L1, L2);
        [end_x, end_y] = FK(theta1, theta2, L1, L2);

        x1 = L1 * cos(theta1);
        y1 = L1 * sin(theta1);
        x2 = end_x;
        y2 = end_y;

        cla;
        % 타원 궤적
        plot(x, y, 'g--');
        % j0->j1
        plot([0 x1], [0 y1], 'b', 'linewidth', 2);
        %  j1->j2
        plot([x1, x2], [y1 y2], 'r', 'linewidth', 2);
        % 엔드 이펙터
        plot(x2, y2, 'ko', 'markersize', 10, 'markerFaceColor', 'k');

        plot(target_x, target_y, 'gx', 'markersize', 10);

        pause(0.1);
    endfor

endfunction

twoDofRobotIK_Sim()
