function y = fmean1(Window)
[lv, lu] = size(Window);
N = lv*lu;
M = 0;
    for i1 = 1:N
        M = M + Window(i1);
    end
y = M/N; 
end
        
