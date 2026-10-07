clc;
clear;
close all;

% 초기 정사각형의 꼭짓점
% 마지막 점을 첫 점과 같게 하여 닫힌 사각형으로 표현
vertices = [0, 5, 5, 0, 0;
            0, 0, 5, 5, 0];

% 스케일링 설정
scale = 1.0;
scale_factor = 0.95;
min_side_length = 0.5;
initial_side_length = 5;

% 그래프 설정
figure;
hold on;
grid on;
axis equal;
xlim([-6, 6]);
ylim([-6, 6]);
xlabel('X');
ylabel('Y');

% 네 변을 각각 따로 만들어 변환 후 한 변씩 갱신
hEdge = zeros(1, 4);
for edge = 1:4
    hEdge(edge) = plot(vertices(1, edge:edge+1), ...
                       vertices(2, edge:edge+1), ...
                       'b-', 'LineWidth', 2);
end

% 한 변의 길이가 0.5 이하가 될 때까지 축소
while initial_side_length * scale >= min_side_length
    % 스케일링 행렬 S = [s 0; 0 s]
    S = [scale, 0;
         0, scale];
    scaled_vertices = S * vertices;

    % 각 변의 꼭짓점을 순서대로 갱신
    for edge = 1:4
        set(hEdge(edge), ...
            'XData', scaled_vertices(1, edge:edge+1), ...
            'YData', scaled_vertices(2, edge:edge+1));
    end

    side_length = initial_side_length * scale;
    title(sprintf('Shrinking square: side length = %.2f', side_length));
    drawnow;
    pause(0.08);

    scale = scale * scale_factor;
end
