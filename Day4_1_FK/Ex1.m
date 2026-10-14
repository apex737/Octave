L1 = 1;
L2 = 1;

theta1 = pi / 2;
theta2 = pi / 4;

DH = [0, 0, 0, theta1;
    0, L1, 0, theta2;
    0, L2, 0, 0];

% T01 = Rot(z1, theta1)
T01 = [cos(theta1), -sin(theta1), 0, 0;
    sin(theta1), cos(theta1), 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];

% T12 = Trans(x1, l1)Rot(z2, theta2)
T12_t = [1, 0, 0, L1;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];

T12_r = [cos(theta2), -sin(theta2), 0, 0;
    sin(theta2), cos(theta2), 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];

T12 = T12_t * T12_r;

% T23 = Trans(x1, l1)Rot(z2, theta2)
T23 = [1, 0, 0, L2;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];

T = T01 * T12 * T23;

x1 = T01(1, 4)
y1 = T01(2, 4)

x2 = (T01 * T12)(1, 4);
y2 = (T01 * T12)(2, 4);

x3 = T(1, 4);
y3 = T(2, 4);

% 첫 번째 링크 그리기
plot([0, x1], [0, y1], 'r-', 'LineWidth', 3);
hold on;

% 두 번째 링크 그리기
plot([x1, x2], [y1, y2], 'g-', 'LineWidth', 3);

% 세 번째 링크 (끝점) 그리기
plot([x2, x3], [y2, y3], 'b-', 'LineWidth', 3);

% 관절 위치에 점 표시 (다양한 색상과 스타일)
##plot(0, 0, 'mo', 'MarkerSize', 10, 'MarkerFaceColor', 'm');  % 첫 번째 관절 (원점)
plot(x1, y1, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % 두 번째 관절
plot(x2, y2, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); % 세 번째 관절
plot(x3, y3, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); % 매니퓰레이터 끝점

% 축 설정
axis equal;
axis([-2 2 -2 2]);
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('2-Link RR Manipulator');
hold off;
