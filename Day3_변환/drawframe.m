% Day3_변환/drawframe.m
function drawframe(T, c)
    for k = 1:3
        quiver3(T(1,4),T(2,4),T(3,4), T(1,k),T(2,k),T(3,k), 0, c(k), 'linewidth',2);
    end
endfunction
