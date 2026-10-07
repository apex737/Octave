clc;clear;close all;

% 1번
x = input('x값을 입력하세요: ');
if mod(x, 2) == 0
    disp('Even');
else
    disp('Odd');
end

% 2번
v = 1:10;
for i = 1:length(v)
    disp(i);
end

v2 = 1:100;
for i = 1:length(v2)
    if(mod(v2(i), 3) == 0)
        disp(v2(i));
    end
end

% 3번
function y = factorial_recursive(n)
    if n == 0
        y = 1;
    else
        y = n * factorial_recursive(n - 1);
    end
end

factorial_result = factorial_recursive(5);
disp(factorial_result);

% 4번
a = input('a값을 입력하세요: ');
b = input('b값을 입력하세요: ');
if a == b
    disp('Equal');
elseif a > b
    disp('a is greater than b');
else
    disp('b is greater than a');
end


% 5번
x = input('x값을 입력하세요: ');
y = input('y값을 입력하세요: ');
z = input('z값을 입력하세요: ');
if x > 0 && y > 0 && z > 0
    disp('All Positive');
elseif x < 0 || y < 0 || z < 0
    disp('Contains Negative');
elseif x == 0 || y == 0 || z == 0
    disp('Contains Zero');
end