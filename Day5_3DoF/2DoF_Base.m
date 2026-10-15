clc; clear; close all;

function robot_arm_gui()
    % 링크 길이 정의: 로봇의 기하학적 파라미터
    L1 = 1.0;
    L2 = 0.8;

    % 전역 구조체 생성 및 저장 (GUI 요소 핸들 및 데이터를 담기 위한 컨테이너)
    h = struct();

    % 새 figure 창 생성 (GUI 컨테이너)
    h.fig = figure(...
        'Position', [100, 100, 600, 500], ...
        'Name', '2-DOF Robot Arm Kinematics', ...
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

    % 그래프 축 라벨 및 설정
    xlabel('X Position');
    ylabel('Y Position');
    grid on;
    hold on;

    % 로봇 팔을 그릴 초기 라인 객체 생성
    h.arm_plot = plot([0, 0, 0], [0, 0, 0], 'b-o', 'LineWidth', 3, 'MarkerSize', 8);
    h.end_effector = plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    h.base = plot(0, 0, 'ks', 'MarkerSize', 12, 'MarkerFaceColor', 'k');

    % 로봇 팔의 현재 각도 값 (라디안)
    h.theta1_val = 0.0;
    h.theta2_val = 0.0;

    % 링크 길이 데이터도 콜백 함수에서 사용하도록 구조체에 저장
    h.L1 = L1;
    h.L2 = L2;

    % Theta 1 (첫 번째 관절 각도) 슬라이더 및 라벨 생성
    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 160, 100, 20], 'String', 'Theta 1:');
    h.theta1_text = uicontrol(h.fig, 'Style', 'text', 'Position', [480, 160, 50, 20], 'String', num2str(rad2deg(h.theta1_val), '%5.1f'));
    h.theta1_slider = uicontrol(h.fig, 'Style', 'slider', ...
        'Min', -pi, 'Max', pi, 'Value', h.theta1_val, ...
        'Position', [140, 160, 320, 20], ...
        'Callback', @update_arm_plot);

    % Theta 2 (두 번째 관절 각도) 슬라이더 및 라벨 생성
    uicontrol(h.fig, 'Style', 'text', 'Position', [30, 100, 100, 20], 'String', 'Theta 2:');
    h.theta2_text = uicontrol(h.fig, 'Style', 'text', 'Position', [480, 100, 50, 20], 'String', num2str(rad2deg(h.theta2_val), '%5.1f'));
    h.theta2_slider = uicontrol(h.fig, 'Style', 'slider', ...
        'Min', -pi, 'Max', pi, 'Value', h.theta2_val, ...
        'Position', [140, 100, 320, 20], ...
        'Callback', @update_arm_plot);

    % End-Effector 좌표 표시 UI 추가
    uicontrol(h.fig, 'Style', 'text', ...
        'Position', [30, 40, 150, 20], ...
        'String', 'End-Effector Position:', ...
        'HorizontalAlignment', 'left');

    % X 좌표 표시 텍스트 (초기값은 theta1=0, theta2=0일 때의 위치)
    h.x_coord_text = uicontrol(h.fig, 'Style', 'text', ...
        'Position', [190, 40, 100, 20], ...
        'String', sprintf('X: %5.2f', L1 + L2), ...
        'HorizontalAlignment', 'left');

    % Y 좌표 표시 텍스트
    h.y_coord_text = uicontrol(h.fig, 'Style', 'text', ...
        'Position', [300, 40, 100, 20], ...
        'String', sprintf('Y: %5.2f', 0.0), ...
        'HorizontalAlignment', 'left');

    % 핸들 구조체 h를 figure에 저장
    guidata(h.fig, h);

    % 초기 그림 업데이트
    update_arm_plot(h.fig);
end

% 슬라이더 콜백 함수
function update_arm_plot(obj, ~)
    % figure 핸들을 찾고 저장된 핸들 구조체 'h'를 로드
    fig = ancestor(obj, 'figure');
    h = guidata(fig);

    % 현재 슬라이더 값 가져오기
    h.theta1_val = get(h.theta1_slider, 'Value');
    h.theta2_val = get(h.theta2_slider, 'Value');

    % 각도 텍스트 업데이트
    set(h.theta1_text, 'String', num2str(rad2deg(h.theta1_val), '%5.1f'));
    set(h.theta2_text, 'String', num2str(rad2deg(h.theta2_val), '%5.1f'));

    % 정기구학 계산
    [x_end, y_end] = forward_kinematics(h.theta1_val, h.theta2_val, h.L1, h.L2);

    % 말단 장치 좌표 텍스트 업데이트
    set(h.x_coord_text, 'String', sprintf('X: %5.2f', x_end));
    set(h.y_coord_text, 'String', sprintf('Y: %5.2f', y_end));

    % Link 1 끝점 (두 번째 관절) 좌표 계산
    x_joint = h.L1 * cos(h.theta1_val);
    y_joint = h.L1 * sin(h.theta1_val);

    % 로봇 팔을 그릴 좌표 데이터 준비
    X = [0, x_joint, x_end];
    Y = [0, y_joint, y_end];

    % 로봇 팔 라인 및 말단 장치 위치 업데이트
    set(h.arm_plot, 'XData', X, 'YData', Y);
    set(h.end_effector, 'XData', x_end, 'YData', y_end);

    % 변경된 핸들 구조체를 figure에 다시 저장
    guidata(h.fig, h);
end

% 정기구학 계산 함수
function [x, y] = forward_kinematics(theta1, theta2, l1, l2)
    x = l1 * cos(theta1) + l2 * cos(theta1 + theta2);
    y = l1 * sin(theta1) + l2 * sin(theta1 + theta2);
end

robot_arm_gui();
