% 2자유도(RR) 로봇 원형 경로 생성 및 역기구학 시뮬레이션
clear; clc; close all;

% 1. 링크 길이 설정 (환경에 따라 1.0 등으로 설정)
l1 = 1.0;
l2 = 1.0;

% 2. 원 경로 조건 설정
num_points = 100; % 경로를 따라 생성할 점의 수
center = [1.0; 0.5]; % 원의 중심 (x, y)
radius = 0.5; % 원의 반지름

% 3. 원 경로 좌표 생성 (매개변수 방정식 이용)
theta_circle = linspace(0, 2 * pi, num_points);
x_path = center(1) + radius * cos(theta_circle);
y_path = center(2) + radius * sin(theta_circle);

% 4. 역기구학(IK)을 이용한 각 관절 각도 계산 및 시뮬레이션
theta1_history = zeros(1, num_points);
theta2_history = zeros(1, num_points);

figure('Name', '2DOF Robot Circular Path', 'Color', 'white');

for i = 1:num_points
    x = x_path(i);
    y = y_path(i);

    % 역기구학 공식 (Elbow-down 기준 예시)
    r_sq = x^2 + y^2;
    cos_theta2 = (r_sq - l1^2 - l2^2) / (2 * l1 * l2);

    % 수치 계산 오차 방지
    cos_theta2 = max(min(cos_theta2, 1.0), -1.0);

    % theta2 (관절 2 각도: 음수 해 또는 양수 해 선택 가능)
    theta2 = acos(cos_theta2);

    % theta1 (관절 1 각도)
    theta1 = atan2(y, x) - atan2(l2 * sin(theta2), l1 + l2 * cos(theta2));

    theta1_history(i) = theta1;
    theta2_history(i) = theta2;

    % 로봇 링크 위치 계산 (순기구학)
    x1 = l1 * cos(theta1);
    y1 = l1 * sin(theta1);
    x2 = x;
    y2 = y;

    % 시뮬레이션 시각화 업데이트
    plot([0, x1, x2], [0, y1, y2], '-o', 'LineWidth', 3, 'MarkerSize', 6, ...
        'MarkerFaceColor', 'r', 'Color', [0.1, 0.6, 0.2]);
    hold on;
    plot(x_path, y_path, 'b--', 'LineWidth', 1.5); % 목표 원 경로
    hold off;

    grid on;
    axis([-0.5, 2.0, -0.5, 1.5]);
    xlabel('X'); ylabel('Y');
    title(sprintf('2DOF Robot Circular Motion (%d / %d)', i, num_points));
    drawnow;
end
