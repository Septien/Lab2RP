function y = fhomogeneity(Window)
[lv, lu] = size(Window);
%Window = Window';
N = lv*lu;
y = 0;
for i1 = 1:N
        y = y + (1/(i1+1))*Window(i1);
end 
end