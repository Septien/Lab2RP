function y = fcontrast(Window)
[lv, lu] = size(Window);
N = lv*lu;
y = 0;
for i1 = 1:N
        y = y + (i1)^2*Window(i1);
end 
end