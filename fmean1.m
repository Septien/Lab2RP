function y = fmean1(Window)
[lv, lu] = size(Window);
%Window = Window';
N = lv*lu;
M = 0;
    for i1 = 1:N
        M = i1*Window(i1);
    end
y = 0.5*M; 
end
        
