% 원통좌표계 (r, theta, z)
%   x축으로 r 이동 -> z축으로 theta 회전 -> z방향으로 z 이동
%   A_T = Trans(Z, z) * Rot(Z, theta) * Trans(X, r)
clc; clear; close all;
function T = cylT(r, theta, z)
    th = theta*pi/180;
    T = [1 0 0 0; 0 1 0 0; 0 0 1 z; 0 0 0 1] * ...
        [cos(th) -sin(th) 0 0; sin(th) cos(th) 0 0; 0 0 1 0; 0 0 0 1] * ...
        [1 0 0 r; 0 1 0 0; 0 0 1 0; 0 0 0 1];
endfunction

r = 3; theta = 30; z = 2;          % 예시 값
T_cyl = cylT(r, theta, z);
P_A = T_cyl * [0; 0; 0; 1];        % 원점이 옮겨간 위치 = A_P
disp('A_P =');
disp(P_A(1:3)');                   % (r cos(theta), r sin(theta), z)

figure; hold on; grid on;
drawFrame(eye(4), 'O', [-0.3 -0.3 0], 2);
drawFrame(T_cyl, 'P', [0.2 0.2 0.2], 2);
plot3(P_A(1), P_A(2), P_A(3), 'ko', 'MarkerFaceColor', 'k');
plot3([0 r*cosd(theta)], [0 r*sind(theta)], [0 0], 'k:');                       % r
plot3([r*cosd(theta) P_A(1)], [r*sind(theta) P_A(2)], [0 z], 'k:');             % z
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Problem 2 : Cylindrical coordinate');
view(3);
hold off;