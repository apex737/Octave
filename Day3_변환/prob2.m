clc;clear;close all;

% 1번
function y = ans1(theta, P)
    theta = theta*pi/180;
    R = [   cos(theta), -sin(theta), 0;
            sin(theta), cos(theta), 0;
            0 , 0 , 1; ];
    y = R*P';
endfunction;

disp(ans1(30, [1 0 0]));
disp(ans1(45, [1 0 0]));
disp(ans1(90, [1 0 0]));

% 2번
function y = ans2(P)
    theta = 30*pi/180;
    R = [   cos(theta), -sin(theta), 0;
            sin(theta), cos(theta), 0;
            0 , 0 , 1; ];
    y = R*P';
endfunction

disp(ans2([0 2 0]));

% 1. 설정
m = 2; n = 1;
origin_A = [0; 0; 0];
origin_B = [m; n; 0];

% 2. 좌표계 {A} 축 그리기 (quiver3)
figure;
hold on;
grid on;
quiver3(0, 0, 0, 4, 0, 0, 'r', 'LineWidth', 2); % X_A (빨강)
quiver3(0, 0, 0, 0, 4, 0, 'g', 'LineWidth', 2); % Y_A (초록)

% 3. 좌표계 {B} 축 그리기
quiver3(m, n, 0, 1, 0, 0, 'r', 'LineWidth', 1.5); % X_B
quiver3(m, n, 0, 0, 1, 0, 'g', 'LineWidth', 1.5); % Y_B

% 4. 점 P 표시 (plot3)
% {A} 기준 좌표 (3, 2, 0) 또는 {B} 기준 점 위치 시각화
P_A = [3; 2; 0];
plot3(P_A(1), P_A(2), P_A(3), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);

axis([-1, 5, -1, 5, 0, 2]);
xlabel('X_A'); ylabel('Y_A'); zlabel('Z_A');
view(2); % 2차원 평면 보기 형태
hold off;