clc;clear;close all;

function y = rotTrans(theta, tx, ty, P)
        theta = theta*pi/180;
        T = [   cos(theta) -sin(theta) tx;
                sin(theta) cos(theta) ty;
                0 0 1];
        y = T*P';
endfunction

% 1번
rotTrans(30, 10, 5, [3,7,1])

% 2번
theta = 30*pi/180;
T = [   cos(theta) -sin(theta) 4;
        sin(theta) cos(theta) 3;
        0 0 1];

disp(T); disp(inv(T)); 

% 3-4번
function y = rot(p, theta, phi)
    theta = theta * pi / 180;
    phi = phi * pi / 180;
    Rz = [  cos(theta) -sin(theta) 0;
            sin(theta) cos(theta) 0;
            0 0 1];

    Rx = [  0 0 1;
            cos([phi]) -sin([phi]) 0;
            sin([phi]) cos([phi]) 0];
    y = Rz*Rx*p';
endfunction

ans4 = rot([1,1,1], 30, 45);
disp(ans4);
