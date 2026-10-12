clc; clear; close all;
figure; hold on; grid on; axis equal;

c  = 'rgb';
c2 = 'mck';

O = eye(4);                                   % 원점, 단위행렬 그대로
A = O;  A(3,4) = 3;                           % z로 3 이동
B = A;  B(1:3,1:3) = rotmat(30,'Z');          % A 위치에서 Z 30도 회전
C = B;  C(2,4) = 4;                           % y로 4 이동
D = C;  D(1,4) = 1;                           % x로 1 이동
E = D;  E(1:3,1:3) = rotmat(45,'Z')*D(1:3,1:3); % 45도 추가 회전

drawframe(O, c);
drawframe(A, c);
drawframe(B, c);
drawframe(C, c);
drawframe(D, c);
drawframe(E, c2);

xlabel('X-Axis'); ylabel('Y-Axis'); zlabel('Z-Axis');
