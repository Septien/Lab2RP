close all;
clc;
clear;

%% leer archivos
if ispc
    d='\';
else
    d='/';
end

pht1 = [pwd d , 'Fallas', d];
fl1=dir([pht1  '*.tif']);
nIm=length(fl1)/2;
dir = [0 1;-1 1; -1 0;-1 -1];

%% For SDH Feacture Matrix
Window_width = [3 5 7 9 11 13 15 17 19 21 23 25];
Wave_Number = 5;
Points_Number = 50;
Windows_Number=length(Window_width);
SDH_feature_matrix = double(zeros(nIm*Points_Number,(length(Window_width))*Wave_Number));

for i1=1:nIm
    imrgb = imread([pht1 fl1(i1).name]);
    im = rgb2gray(imrgb);
    im = im2double(im);
    [lv,lu] = size(im);
    
    for i2=1:Windows_Number
        Window_point = zeros((Window_width(i2)));
        mxu = (lu - 1-Window_width(i2));
        mxv = (lv - 1-Window_width(i2));
        mn = (1+Window_width(i2));
        id1 = 1-ceil(Window_width(i2)/2);
        id2 = ceil(Window_width(i2)/2) +1 -2*mod(ceil(Window_width(i2)/2),2);
        
        for i3 = 1:Points_Number
            OWu = floor((mxu-mn)*rand()+mn);
            OWv = floor((mxv-mn)*rand()+mn);
            Window_point = im(OWv+id1:OWv+id2,OWu+id1:OWu+id2);
            [sumImg, diffImg] = sumDifImgs(Window_point);
            %% Feature Calculation
            SDH_feature_matrix(Points_Number*(i1-1)+i3,(i2-1)*5+1:(i2-1)*5+5) = [fcorrelation(sumImg,diffImg),fcontrast(diffImg),fhomogeneity(diffImg),fCShade(sumImg),fCProminece(sumImg)];
        end
    end
end

percentage = 1;
[coeffsdhl,sdhlPropsPCA,latentsdhl,tsquaredsdhl,explainedsdhl] = pca(SDH_feature_matrix', 'NumComponents', nIm * percentage);%Datos nuevos extraidos del PCA
%% Gr\'afica
% explainsum=zeros(length(explainedsdhl)+1,1);
% explainsum(1) = 0;
% explainsum(2) = explainedsdhl(1);
% for i4=3:length(explainedsdhl)+1
%     explainsum(i4) = explainsum(i4-1) + explainedsdhl(i4-1);
% end

explainsum=zeros(length(explainedsdhl),1);
explainsum(1) = explainedsdhl(1);
for i4=2:length(explainedsdhl)
    explainsum(i4) = explainsum(i4-1) + explainedsdhl(i4);
end

figure(1)
plot(explainsum,'r-*');
grid on;
xlim([0 60]);
ylim([0 100]);
xlabel('Caracteristicas');
ylabel('Porcentaje acumulado');
title('Porcentaje de caracteristicas PCA');
print('-f1', '-djpeg80','-r300','FIG_SHD_PCA.jpg');


    