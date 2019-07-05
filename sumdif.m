close all;
clc;
clear all;

nIm=1   ;
% leer archivos
fname = '../imas/ima';
fnamext= '.gif';
dir = [0 1;-1 1; -1 0;-1 -1];

for i=1:nIm
    imA = strcat(fname, num2str(i), fnamext);
    im = imread(imA);
    [sumImg, diffImg] = sumDifImgs(im);
end