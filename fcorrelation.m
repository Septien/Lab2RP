function y = fcorrelation(Window, Window1)
[lv, lu] = size(Window);
[lv1, lu1] = size(Window1);
N = lv*lu;
N1 = lv1*lu1;
M = 0;
M1 =0;
mu = mean(mean(Window));
    for i1 = 1:N
        M = M + (i1-2*mu)^2*Window(i1);
    end
    for i2 = 1:N1
      M1 = M1 + i2^2*Window1(i2);
    end
y = 0.5*(M - M1); 
end