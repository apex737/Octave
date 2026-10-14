clc;clear;close all;

A = diag([1,2,3])
B = [1 2 3; 0 2 3; 0 0 3]
C = [1 0 0; 2 2 0; 3 3 3]
[n,m] = size(A);

is_diagonal = true;
is_upperTri = true;
is_lowerTri = true;


for i = 1:n
  for j = 1:m
    if i ~= j && B(i,j) ~= 0
      is_diagonal = false;
    endif
    if i > j && B(i,j) ~= 0
      is_upperTri = false;
    endif
    if i < j && B(i,j) ~= 0
      is_lowerTri = false;
    endif
  endfor
end

if is_diagonal
  disp("diagonal");
elseif is_upperTri
  disp("upperTri");
elseif is_lowerTri
  disp("lowerTri");
end
