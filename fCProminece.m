function y = fCProminece(Window)
[lv, lu] = size(Window);
N = lv*lu;
%Window = Window';
y = 0;
mu = fmean1(Window);
for i1 = 1:N
        y = y + (i1-2*mu)^4*Window(i1);
    end 
end