clc; clear; close all;

% 링크 길이
L1 = 3;
L2 = 2;

% 관절각 입력: 도 단위
theta1_deg = input('첫 번째 관절각 theta1 (도): ');
theta2_deg = input('두 번째 관절각 theta2 (도): ');

% 라디안으로 변환
theta1 = theta1_deg * pi / 180;
theta2 = theta2_deg * pi / 180;

% 기준점
P0 = [0; 0];

% 첫 번째 링크의 회전행렬
R1 = [cos(theta1), -sin(theta1);
      sin(theta1),  cos(theta1)];

% 두 번째 관절의 상대 회전행렬
R2 = [cos(theta2), -sin(theta2);
      sin(theta2),  cos(theta2)];

% 첫 번째 관절 위치
P1 = P0 + R1 * [L1; 0];

% 두 번째 링크 끝점
% theta2를 첫 번째 링크에 대한 상대각으로 계산
P2 = P1 + R1 * R2 * [L2; 0];

% 좌표 출력
fprintf('P0 = (%.2f, %.2f)\n', P0(1), P0(2));
fprintf('P1 = (%.2f, %.2f)\n', P1(1), P1(2));
fprintf('P2 = (%.2f, %.2f)\n', P2(1), P2(2));

% 로봇팔 그리기
figure;
hold on;
grid on;
axis equal;

plot([P0(1), P1(1), P2(1)], ...
     [P0(2), P1(2), P2(2)], ...
     'b-o', ...
     'LineWidth', 3, ...
     'MarkerSize', 8, ...
     'MarkerFaceColor', 'r');

% 관절과 끝점 표시
text(P0(1), P0(2), '  P0');
text(P1(1), P1(2), '  P1');
text(P2(1), P2(2), '  P2');

xlabel('X');
ylabel('Y');
title('2-Link Robot Arm');

margin = 1;
xlim([-L1-L2-margin, L1+L2+margin]);
ylim([-L1-L2-margin, L1+L2+margin]);