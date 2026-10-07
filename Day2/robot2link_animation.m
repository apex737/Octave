clc;
clear;
close all;

% 링크 길이
L1 = 3;
L2 = 2;

% 초기 관절각: 도 단위
theta1_0 = input('첫 번째 관절의 초기각 theta1 (도): ');
theta2_0 = input('두 번째 관절의 초기각 theta2 (도): ');

% 각 관절의 회전 운동 설정
amplitude1 = 45;   % 첫 번째 관절의 회전 진폭 (도)
amplitude2 = 60;   % 두 번째 관절의 회전 진폭 (도)
frequency1 = 0.25; % 첫 번째 관절의 주파수 (Hz)
frequency2 = 0.50; % 두 번째 관절의 주파수 (Hz)

total_time = 20;   % 애니메이션 시간 (초)
dt = 0.02;         % 프레임 간 시간 간격 (초)

% 처음 위치 계산
theta1 = theta1_0 * pi / 180;
theta2 = theta2_0 * pi / 180;
R1 = [cos(theta1), -sin(theta1);
      sin(theta1),  cos(theta1)];
R2 = [cos(theta2), -sin(theta2);
      sin(theta2),  cos(theta2)];
P0 = [0; 0];
P1 = P0 + R1 * [L1; 0];
P2 = P1 + R1 * R2 * [L2; 0];

% 그래프 준비
fig = figure;
hold on;
grid on;
axis equal;
axis_limit = L1 + L2 + 1;
xlim([-axis_limit, axis_limit]);
ylim([-axis_limit, axis_limit]);
xlabel('X');
ylabel('Y');

% 로봇팔과 끝점 궤적 객체를 한 번만 만들고 좌표만 갱신
hArm = plot([P0(1), P1(1), P2(1)], ...
            [P0(2), P1(2), P2(2)], ...
            'b-o', 'LineWidth', 3, 'MarkerSize', 8, ...
            'MarkerFaceColor', 'r');
hTrace = plot(P2(1), P2(2), 'r--', 'LineWidth', 1);

traceX = P2(1);
traceY = P2(2);

% 시간에 따른 애니메이션
for t = 0:dt:total_time
    if ~ishandle(fig)
        break;
    end

    % 시간에 따라 변하는 관절각 (도)
    theta1_deg = theta1_0 + amplitude1 * sin(2 * pi * frequency1 * t);
    theta2_deg = theta2_0 + amplitude2 * cos(2 * pi * frequency2 * t);

    % 라디안 변환
    theta1 = theta1_deg * pi / 180;
    theta2 = theta2_deg * pi / 180;

    % 회전행렬
    R1 = [cos(theta1), -sin(theta1);
          sin(theta1),  cos(theta1)];
    R2 = [cos(theta2), -sin(theta2);
          sin(theta2),  cos(theta2)];

    % 관절 위치 계산
    P1 = P0 + R1 * [L1; 0];
    P2 = P1 + R1 * R2 * [L2; 0];

    % 끝점 궤적 저장
    traceX(end + 1) = P2(1);
    traceY(end + 1) = P2(2);

    % 그래프 갱신
    set(hArm, 'XData', [P0(1), P1(1), P2(1)], ...
              'YData', [P0(2), P1(2), P2(2)]);
    set(hTrace, 'XData', traceX, 'YData', traceY);
    title(sprintf('2-Link Robot Arm   t = %.2f s', t));

    drawnow;
    pause(dt);
end
