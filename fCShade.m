function y = fCShade(Window)
[lv, lu] = size(Window);
N = lv*lu;
y = 0;
mu = mean(mean(Window));
    for i1 = 1:N
        y = y + (i1-2*mu)^3*Window(i1);
    end 
end