function y = rotTrans(theta, tx, ty, P)
        theta = theta*pi/180;
        T = [   cos(theta) -sin(theta) tx;
                sin(theta) cos(theta) ty;
                0 0 1];
        y = T*P';
endfunction