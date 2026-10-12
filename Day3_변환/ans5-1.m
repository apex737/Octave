clc; clear; close all;

% 4x4 변환행렬 T의 좌표축(X,Y,Z)을 그리고, 좌표계 이름을 off만큼 띄워 표시한다
function drawFrame(T, name, off, lw)
    % 행렬 T의 4열에서 1~3행을 잘라 내라
    o = T(1:3, 4);
    c = 'rgb';
    for k = 1:3
        v = T(1:3, k);
        % 원점 o 로부터 v만큼 증가하므로 종점은 o(i)+v(i)..
        % 
        quiver3(o(1), o(2), o(3), v(1), v(2), v(3), 0, c(k), 'LineWidth', lw);
    end
    text(o(1)+off(1), o(2)+off(2), o(3)+off(3), name, 'FontSize', 12, 'FontWeight', 'bold');
endfunction

% 두 좌표계 원점 사이에 관계를 나타내는 점선 화살표를 그린다
function drawLink(T1, T2)
    a = T1(1:3, 4);
    b = T2(1:3, 4);
    % 둘이 더하면 b가 되도록 하기 위한 패턴
    quiver3(a(1), a(2), a(3), b(1)-a(1), b(2)-a(2), b(3)-a(3), 0, 'k:', 'LineWidth', 1);
endfunction

% ===================== 문제 1 =====================
T_UA = [0.866 -0.500 0 11.0;
        0.500  0.866 0 -1.0;
        0      0     1  8.0;
        0      0     0  1];

T_BA = [1.000 0.000  0.000   0.0;
        0.000 0.866 -0.500  10.0;
        0.000 0.500  0.866 -20.0;
        0     0      0       1];

T_BC = [0.866 -0.500  0.000 -3.0;
        0.433  0.750 -0.500 -3.0;
        0.250  0.433  0.866  3.0;
        0      0      0      1];

% --- 1.A 계의 도형 (quiver3) ---
% 모든 계를 U 기준으로 나타낸다.
%   U 기준 A : T_UA
%   U 기준 B : B를 A를 거쳐 구한다. T_UB = T_UA * T_AB = T_UA * inv(T_BA)
%   U 기준 C : T_UC = T_UB * T_BC
T_U  = eye(4);
T_UB = T_UA * inv(T_BA);
T_UC = T_UB * T_BC;

figure; hold on; grid on;
drawFrame(T_U,  'U', [-1 -1 0], 2);
drawFrame(T_UA, 'A', [-1 -1 0], 2);
drawFrame(T_UB, 'B', [-1 -1 0], 2);
drawFrame(T_UC, 'C', [-1 -1 0], 2);
drawLink(T_U,  T_UA);    % U -> A
drawLink(T_UB, T_UA);    % B -> A
drawLink(T_UB, T_UC);    % B -> C
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Problem 1-A : U, A, B, C');
view(3);
hold off;

% --- 1.B 합성 : U_C T = U_A T * (B_A T)^-1 * B_C T ---
T_UC = T_UA * inv(T_BA) * T_BC;
disp('U_C T =');
disp(T_UC);

