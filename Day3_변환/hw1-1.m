clc; clear; close all;

I = eye(3);

figure; hold on; grid on; axis equal;
c = 'rgb';
for k = 1:3
      quiver3(0,0,0, I(1,k), I(2,k), I(3,k), 0, c(k), 'linewidth', 2);
end

R = rotmat(45, 'Z') * I;

d = 'mck';                              % 회전된 축은 다른 색 (마젠타/시안/검정)
for k = 1:3
    quiver3(0, 0, 0,  R(1,k),  R(2,k),  R(3,k), 0, d(k), 'LineWidth', 2);
end

xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);