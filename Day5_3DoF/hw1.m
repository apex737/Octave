clc; clear; close all;

% DH (a_(i-1), alpha_(i-1), d_i. theta_i 순)
% 1: [0,0,0,theta_1]
% 2: [0,90,0,theta_2]
% 3: [L1,0,0,theta_3]
% E: [L2,0,0,0]

% Modified DH: Tx(a) * Rx(alpha) * Tz(d) * Rz(theta)
% Joint angles are in radians. Link lengths use the same unit as x, y, z.
function [x, y, z] = FK(theta1, theta2, theta3, L1, L2)
    % Horizontal distance from the base rotation axis to the end effector.
    r = L1 * cos(theta2) + L2 * cos(theta2 + theta3);

    x = r * cos(theta1);
    y = r * sin(theta1);
    z = L1 * sin(theta2) + L2 * sin(theta2 + theta3);
endfunction

function robot_arm_gui()
    h = struct();
    h.L1 = 1.0;
    h.L2 = 0.8;
    h.fig = figure('Position', [100, 100, 720, 680], ...
        'Name', '3-DoF Robot Arm - Forward Kinematics', ...
        'NumberTitle', 'off');

    reach = 1.1 * (h.L1 + h.L2);
    h.ax = axes('Parent', h.fig, 'Units', 'pixels', ...
        'Position', [80, 280, 560, 350], ...
        'XLim', [-reach, reach], 'YLim', [-reach, reach], ...
        'ZLim', [-reach, reach], 'DataAspectRatio', [1, 1, 1], ...
        'Box', 'on');
    hold(h.ax, 'on');
    grid(h.ax, 'on');
    view(h.ax, 45, 25);
    xlabel(h.ax, 'X');
    ylabel(h.ax, 'Y');
    zlabel(h.ax, 'Z');
    title(h.ax, 'Robot Arm Position');

    h.arm_plot = plot3(h.ax, [0, 0, 0], [0, 0, 0], [0, 0, 0], ...
        'b-o', 'LineWidth', 3, 'MarkerSize', 8);
    h.end_effector = plot3(h.ax, 0, 0, 0, 'ro', ...
        'MarkerSize', 10, 'MarkerFaceColor', 'r');
    h.base = plot3(h.ax, 0, 0, 0, 'ks', ...
        'MarkerSize', 12, 'MarkerFaceColor', 'k');

    % Display degrees; store slider angles in radians for FK.
    h.theta_sliders = zeros(1, 3);
    h.theta_texts = zeros(1, 3);

    for k = 1:3
        row_y = 210 - (k - 1) * 50;
        uicontrol(h.fig, 'Style', 'text', ...
            'Position', [40, row_y, 90, 20], ...
            'String', sprintf('Theta %d:', k));
        h.theta_sliders(k) = uicontrol(h.fig, 'Style', 'slider', ...
            'Min', -pi, 'Max', pi, 'Value', 0, ...
            'SliderStep', [1/360, 10/360], ...
            'Position', [140, row_y, 440, 20], ...
            'Callback', @update_arm_plot);
        h.theta_texts(k) = uicontrol(h.fig, 'Style', 'text', ...
            'Position', [590, row_y, 90, 20], 'String', '0.0 deg');
    endfor

    h.coord_text = uicontrol(h.fig, 'Style', 'text', ...
        'Position', [40, 40, 640, 30], ...
        'HorizontalAlignment', 'left', 'FontSize', 11, 'String', '');

    guidata(h.fig, h);
    update_arm_plot(h.fig, []);
endfunction

function update_arm_plot(obj, ~)
    fig = ancestor(obj, 'figure');
    h = guidata(fig);
    theta = zeros(1, 3);

    for k = 1:3
        theta(k) = get(h.theta_sliders(k), 'Value');
        set(h.theta_texts(k), 'String', ...
            sprintf('%5.1f deg', rad2deg(theta(k))));
    endfor

    [x_end, y_end, z_end] = FK(theta(1), theta(2), theta(3), h.L1, h.L2);

    % Elbow: first link rotated by the base and shoulder joints.
    x_joint = h.L1 * cos(theta(2)) * cos(theta(1));
    y_joint = h.L1 * cos(theta(2)) * sin(theta(1));
    z_joint = h.L1 * sin(theta(2));

    set(h.arm_plot, 'XData', [0, x_joint, x_end], ...
        'YData', [0, y_joint, y_end], 'ZData', [0, z_joint, z_end]);
    set(h.end_effector, 'XData', x_end, 'YData', y_end, 'ZData', z_end);
    set(h.coord_text, 'String', sprintf(...
        'End-Effector   X: %6.3f    Y: %6.3f    Z: %6.3f', ...
        x_end, y_end, z_end));
    drawnow();
endfunction

robot_arm_gui();
