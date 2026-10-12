function y = rotmat(theta, axis)
    theta = theta*pi/180;
    if axis == 'X'
        M = [1, 0, 0;
            0, cos(theta), -sin(theta);
            0, sin(theta), cos(theta)];
    elseif axis == 'Y'
        M = [cos(theta), 0, sin(theta);
            0, 1, 0;
            -sin(theta), 0, cos(theta)];
    elseif axis == 'Z'
        M = [cos(theta), -sin(theta), 0;
            sin(theta), cos(theta), 0;
            0, 0, 1];
    end
    y = M;
endfunction
