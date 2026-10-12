function y = translate(val, axis)
    if axis == 'X'
        y = [1,0,0,val
             0,1,0,0
             0,0,1,0];
    elseif axis == 'Y'
        y = [1,0,0,0
             0,1,0,val
             0,0,1,0];
    elseif axis == 'Z'
        y = [1,0,0,0
             0,1,0,0
             0,0,1,val];
    end
endfunction