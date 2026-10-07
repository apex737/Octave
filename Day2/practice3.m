clear; clc; close all;

figure;
hold on;
grid on;
axis equal;
% 1번

x1 = -10:0.1:10;
y1 = 2*x1 + 1;
plot(x1, y1, 'r--', 'LineWidth', 2);
xlabel('x-axis');
ylabel('y-axis');
title('linear function y = 2x + 1');

% 2번
xlim([-6 6]);
ylim([0 25]);
x2 = -5:0.5:5;
y2 = x2.^2;

% 파란색 포물선 그리기
plot(x2, y2, 'b-', 'LineWidth', 2);
hold on;

% 각 데이터 점마다 초록색 원 표시
plot(x2, y2, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
xlabel('x-axis');
ylabel('y-axis');
title('Quadratic function y = x^2');

% 3번
xlim([0 7]);
ylim([-1 1]);
x3 = 0:0.1:2*pi;
y3_1 = sin(x3);
y3_2 = cos(x3);

plot(x3, y3_1, 'g--', 'LineWidth', 2);
hold on;
plot(x3, y3_2, 'b-', 'LineWidth', 2);
xlabel('x-axis');
ylabel('y-axis');
legend('sin(x)', 'cos(x)');
title('Sine and Cosine functions');

% 4번
x4 = 0:0.01:5;

% 원소별 곱셈인 .*를 사용해야 합니다.
y4 = exp(-x4) .* sin(2*pi*x4);
% xticks(0:0.5:5);     % x축 간격 0.5
% yticks(-1:0.2:1);     % y축 간격 0.2
xlim([-1 5]);
ylim([-1 1]);
plot(x4, y4, 'r-', 'LineWidth', 2);

title('Damped Oscillation: y = e^{-x} * sin(2πx)');