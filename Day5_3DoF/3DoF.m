clear; clc; close all;
## 1. 메인 GUI 설정 함수
function robot_arm_gui_final()
    % 링크 길이 정의
    L1 = 1.0;
    L2 = 0.8;

    % 핸들 저장을 위한 구조체 생성
    h = struct();

    % 새 figure 창 생성
    h.fig = figure(...
        'Position', [100, 100, 600, 500], ...
        'Name', '2-DOF Robot Arm Kinematics (Forward & Inverse)', ...
        'NumberTitle', 'off');

    % Axes (그래프 영역) 설정
    h.ax = axes(...
        'Parent', h.fig, ...
        'Units', 'pixels', ...
        'Position', [60, 225, 480, 250], ...
        'XLim', [-(L1 + L2) * 1.1, (L1 + L2) * 1.1], ...
        'YLim', [-(L1 + L2) * 1.1, (L1 + L2) * 1.1], ...
        'DataAspectRatio', [1 1 1], ...
        'Box', 'on', ...
        'Title', 'Robot Arm Position');

    xlabel('X Position');
    ylabel('Y Position');
    grid on;
    hold on;

    % 로봇 팔 및 타겟 위치를 그릴 초기 plot 객체 생성
    h.arm_plot = plot([0, 0, 0], [0, 0, 0], 'b-o', 'LineWidth', 3, 'MarkerSize', 8);
    h.end_effector = plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    h.target_pos = plot(0, 0, 'gx', 'MarkerSize', 12, 'LineWidth', 2.5, 'Visible', 'off');
    h.base = plot(0, 0, 'ks', 'MarkerSize', 12, 'MarkerFaceColor', 'k');

    % 초기 관절 각도
    h.theta1_val = 0.0;
    h.theta2_val = 0.0;
    h.L1 = L1;
    h.L2 = L2;

    % 1. 정기구학 제어 영역 (슬라이더)
    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 160, 100, 20], 'String', 'Theta 1:');
    h.theta1_text = uicontrol(h.fig, 'Style', 'text', 'Position', [480, 160, 50, 20], 'String', num2str(rad2deg(h.theta1_val), '%5.1f'));
    h.theta1_slider = uicontrol(h.fig, 'Style', 'slider', ...
        'Min', -pi, 'Max', pi, 'Value', h.theta1_val, 'Position', [140, 160, 320, 20], 'Callback', @slider_callback);

    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 120, 100, 20], 'String', 'Theta 2:');
    h.theta2_text = uicontrol(h.fig, 'Style', 'text', 'Position', [480, 120, 50, 20], 'String', num2str(rad2deg(h.theta2_val), '%5.1f'));
    h.theta2_slider = uicontrol(h.fig, 'Style', 'slider', ...
        'Min', -pi, 'Max', pi, 'Value', h.theta2_val, 'Position', [140, 120, 320, 20], 'Callback', @slider_callback);

    % 2. 역기구학 제어 영역
    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 80, 60, 20], 'String', 'Target X:');
    h.x_input = uicontrol(h.fig, 'Style', 'edit', 'Position', [90, 80, 60, 20], 'String', '1.0');

    uicontrol(h.fig, 'Style', 'text', 'Position', [160, 80, 60, 20], 'String', 'Target Y:');
    h.y_input = uicontrol(h.fig, 'Style', 'edit', 'Position', [220, 80, 60, 20], 'String', '0.5');

    h.move_button = uicontrol(h.fig, 'Style', 'pushbutton', 'Position', [300, 80, 120, 25], ...
        'String', 'Move to Target', 'Callback', @move_to_target_callback);

    % 3. 현재 좌표 표시 영역
    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 40, 150, 20], ...
        'String', 'Current End-Effector:', 'HorizontalAlignment', 'left');
    h.x_coord_text = uicontrol(h.fig, 'Style', 'text', 'Position', [190, 40, 100, 20], ...
        'String', sprintf('X: %5.2f', L1 + L2), 'HorizontalAlignment', 'left');
    h.y_coord_text = uicontrol(h.fig, 'Style', 'text', 'Position', [300, 40, 100, 20], ...
        'String', sprintf('Y: %5.2f', 0.0), 'HorizontalAlignment', 'left');

    % 핸들 구조체를 figure에 저장
    guidata(h.fig, h);

    % 초기 그림 업데이트
    update_arm_plot(h.fig);
end

## 2. 콜백 함수들
% 슬라이더를 움직였을 때 호출되는 함수
function slider_callback(obj, ~)
    fig = ancestor(obj, 'figure');
    h = guidata(fig);
    % 슬라이더 값으로 로봇 팔 위치 업데이트
    h.theta1_val = get(h.theta1_slider, 'Value');
    h.theta2_val = get(h.theta2_slider, 'Value');
    % 목표 위치 마커는 숨김
    set(h.target_pos, 'Visible', 'off');

    guidata(fig, h); % <--- 수정된 부분: 그리기 전에 상태를 먼저 저장합니다.

    % 공통 업데이트 함수 호출
    update_arm_plot(h.fig);
end

% 'Move to Target' 버튼을 눌렀을 때 호출되는 함수
function move_to_target_callback(obj, ~)
    fig = ancestor(obj, 'figure');
    h = guidata(fig);

    % 1. X, Y 입력 값 읽기
    target_x = str2double(get(h.x_input, 'String'));
    target_y = str2double(get(h.y_input, 'String'));

    % 2. 목표 위치에 마커 표시
    set(h.target_pos, 'XData', target_x, 'YData', target_y, 'Visible', 'on');

    % 3. 역기구학 계산
    [theta1_new, theta2_new] = inverse_kinematics(target_x, target_y, h.L1, h.L2);

    % 4. 계산 성공 시에만 로봇 팔 업데이트
    if ~isnan(theta1_new)
        h.theta1_val = theta1_new;
        h.theta2_val = theta2_new;

        guidata(fig, h); % <--- 수정된 부분: 그리기 전에 상태를 먼저 저장합니다.

        % 공통 업데이트 함수 호출
        update_arm_plot(h.fig);
    else
        % 도달 불가능할 경우 사용자에게 알림
        warndlg('Target position is out of reach!', 'IK Error');
    end

end

% 로봇 팔의 시각적 요소를 업데이트하는 공통 함수
function update_arm_plot(fig)
    h = guidata(fig);

    % 현재 각도 값(h.theta1_val, h.theta2_val)으로 정기구학 계산
    [x_end, y_end] = forward_kinematics(h.theta1_val, h.theta2_val, h.L1, h.L2);
    x_joint = h.L1 * cos(h.theta1_val);
    y_joint = h.L1 * sin(h.theta1_val);

    % 로봇 팔 plot 객체 데이터 업데이트
    set(h.arm_plot, 'XData', [0, x_joint, x_end], 'YData', [0, y_joint, y_end]);
    set(h.end_effector, 'XData', x_end, 'YData', y_end);

    % UI 텍스트 및 슬라이더 값 업데이트
    set(h.theta1_text, 'String', num2str(rad2deg(h.theta1_val), '%5.1f'));
    set(h.theta2_text, 'String', num2str(rad2deg(h.theta2_val), '%5.1f'));
    set(h.theta1_slider, 'Value', h.theta1_val);
    set(h.theta2_slider, 'Value', h.theta2_val);
    set(h.x_coord_text, 'String', sprintf('X: %5.2f', x_end));
    set(h.y_coord_text, 'String', sprintf('Y: %5.2f', y_end));

    % 업데이트된 핸들 구조 저장
    guidata(fig, h);
end

## 3. 기구학 계산 함수들
function [x, y] = forward_kinematics(theta1, theta2, l1, l2)
    x = l1 * cos(theta1) + l2 * cos(theta1 + theta2);
    y = l1 * sin(theta1) + l2 * sin(theta1 + theta2);
end

function [theta1, theta2] = inverse_kinematics(x, y, L1, L2)
    cos_theta2 = (x^2 + y^2 - L1^2 - L2^2) / (2 * L1 * L2);

    % 유효성 검사: cos_theta2가 [-1, 1] 범위 내에 있는지 확인
    if abs(cos_theta2) > 1
        theta1 = NaN; % 도달 불가능
        theta2 = NaN;
        return;
    end

    % Elbow-up 해 선택 (+sqrt)
    sin_theta2 = sqrt(1 - cos_theta2^2);
    theta2 = atan2(sin_theta2, cos_theta2);

    % theta1 계산
    k1 = L1 + L2 * cos(theta2);
    k2 = L2 * sin(theta2);

    c1 = (x * k1 + y * k2) / (k1^2 + k2^2);
    s1 = (y * k1 - x * k2) / (k1^2 + k2^2);

    theta1 = atan2(s1, c1);
end

robot_arm_gui_final();
