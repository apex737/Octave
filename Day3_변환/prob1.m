clc;clear;close all;

% 1번
function y = ans1(theta, P)
    theta = theta*pi/180;
    R = [   cos(theta), -sin(theta), 0;
            sin(theta), cos(theta), 0;
            0 , 0 , 1; ];
    y = R*P';
endfunction;

disp(ans1(30, [1 0 0]));
disp(ans1(45, [1 0 0]));
disp(ans1(90, [1 0 0]));

% 2번
function y = ans2(P)
    theta = 30*pi/180;
    R = [   cos(theta), -sin(theta), 0;
            sin(theta), cos(theta), 0;
            0 , 0 , 1; ];
    y = R*P';
endfunction

disp(ans2([0 2 0]));



