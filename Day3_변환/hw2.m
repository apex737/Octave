clc; clear; close all;

I = eye(3);

figure; hold on; grid on; axis equal;
%  O
c = 'rgb';
for k = 1:3
    quiver3(0,0,0,I(1,k),I(2,k),I(3,k),0,c(k),'linewidth',2);
end
% A
for k = 1:3
    quiver3(0,0,3,I(1,k),I(2,k),I(3,k),0,c(k),'linewidth',2);
end

% B
Rz = rotmat(30, 'Z') * I;
for k = 1:3
    quiver3(0,0,3,Rz(1,k),Rz(2,k),Rz(3,k),0,c(k),'linewidth',2);
end

% C
for k = 1:3
    quiver3(0,4,3,Rz(1,k),Rz(2,k),Rz(3,k),0,c(k),'linewidth',2);
end
% D
for k = 1:3
    quiver3(1,4,3,Rz(1,k),Rz(2,k),Rz(3,k),0,c(k),'linewidth',2);
end
% E
Rzz = rotmat(45, 'Z')*Rz;
c2 = 'mck';
for k = 1:3
    quiver3(1,4,3,Rzz(1,k),Rzz(2,k),Rzz(3,k),0,c2(k),'linewidth',2);
end

xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');