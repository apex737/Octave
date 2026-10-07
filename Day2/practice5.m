clc;
clear;
close all;

% 별 모양의 꼭짓점 개수와 두 반지름
N = 5;          % 큰 꼭짓점의 개수 (전체 꼭짓점은 2*N개)
R = 5;          % 큰 반지름
r = 2;          % 작은 반지름

% theta_k = 2*pi*k/(2*N), k = 0, 1, ..., 2*N-1
k = 0:(2*N - 1);
theta = 2*pi*k/(2*N);

% 큰 반지름과 작은 반지름을 번갈아 배치
radii = repmat([R, r], 1, N);

% 변환 전 별 꼭짓점 좌표: 2 x (2*N) 행렬
vertices = [radii .* cos(theta);
            radii .* sin(theta)];

% 스케일링 설정
scale = 1.0;
min_scale = 0.2;
max_scale = 1.0;
scale_step = 0.01;
scale_direction = -1;  % -1: 축소, 1: 확대

% 그래프 설정
fig = figure;
hold on;
grid on;
axis equal;
xlim([-6, 6]);
ylim([-6, 6]);
xlabel('X');
ylabel('Y');

% 별 객체를 한 번 만든 뒤 좌표만 갱신
scaled_vertices = vertices;
hStar = plot([scaled_vertices(1, :), scaled_vertices(1, 1)], ...
             [scaled_vertices(2, :), scaled_vertices(2, 1)], ...
             'm-', 'LineWidth', 2);

while ishandle(fig)
    % 스케일링 행렬 S = [s 0; 0 s]
    S = [scale, 0;
         0, scale];
    scaled_vertices = S * vertices;

    % 변환된 별 좌표로 그래프 갱신
    set(hStar, ...
        'XData', [scaled_vertices(1, :), scaled_vertices(1, 1)], ...
        'YData', [scaled_vertices(2, :), scaled_vertices(2, 1)]);
    title(sprintf('Scaling star: s = %.2f', scale));
    drawnow;
    pause(0.03);

    % 최소 크기까지 줄인 뒤 다시 확대
    scale = scale + scale_direction * scale_step;
    if scale <= min_scale
        scale = min_scale;
        scale_direction = 1;
    elseif scale >= max_scale
        scale = max_scale;
        scale_direction = -1;
    end
end
