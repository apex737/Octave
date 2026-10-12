clc; clear; close all;

I = eye(3);
colors = 'rgb';


figure; hold on; grid on; axis equal;
for k = 1:3
    quiver3(0,0,0,I(1,k),I(2,k),I(3,k),0,colors(k),'linewidth',2);
end

colors2 = 'mck';
o = [3,4,5];
R =  rotmat(30, 'Z') * rotmat(30, 'X') * I;
for k = 1:3
    quiver3(o(1), o(2), o(3), ... 
            R(1,k), R(2,k), R(3,k), ... 
            0, colors2(k), 'linewidth', 2);
end

