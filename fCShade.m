function y = fCShade(Window)
[lv, lu] = size(Window);
%Window = Window';
N = lv*lu;
y = 0;
mu = fmean1(Window);
    for i1 = 1:N
        y = y + (i1-2*mu)^3*Window(i1);
    end 
end