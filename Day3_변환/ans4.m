clc; clear; close all;

% 4x4 변환행렬 T의 좌표축(X,Y,Z)을 그리고, 좌표계 이름을 off만큼 띄워 표시한다
function drawFrame(T, name, off, lw)
    o = T(1:3, 4);
    c = 'rgb';
    for k = 1:3
        v = T(1:3, k);
        quiver3(o(1), o(2), o(3), v(1), v(2), v(3), 0, c(k), 'LineWidth', lw);
    end
    text(o(1)+off(1), o(2)+off(2), o(3), name, 'FontSize', 12, 'FontWeight', 'bold');
endfunction

% A. 좌표계 O
T_O = eye(4);

figure; hold on; grid on;
drawFrame(T_O, 'O', [-0.4 -0.3], 2);
axis([-2 6 -2 6 0 6]);
view(2);                                % Top view

% B. A = Trans(Y, 2)
T_A = [1 0 0 0;
       0 1 0 2;
       0 0 1 0;
       0 0 0 1];
T_OA = T_O * T_A;                       % O에 A 변환 적용
drawFrame(T_OA, 'OA', [-0.7 -0.3], 2);

% C. B = Rot(Z, 60도)
theta = 60 * pi / 180;
R_Z = [cos(theta) -sin(theta) 0 0;
       sin(theta)  cos(theta) 0 0;
       0           0          1 0;
       0           0          0 1];
R_B = R_Z;
T_OB = T_OA * R_B;                      % OA에 B 변환 적용
drawFrame(T_OB, 'OB', [0.2 -0.3], 2);   % 원점이 OA와 같아서 이름을 옆으로 옮김

% D. C = Trans(X, 4)
T_C = [1 0 0 4;
       0 1 0 0;
       0 0 1 0;
       0 0 0 1];
T_OC = T_OB * T_C;                      % OB에 C 변환 적용
drawFrame(T_OC, 'OC', [0.2 0.2], 2);

disp(T_OC);

xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Coordinate System Transformation');
hold off;
