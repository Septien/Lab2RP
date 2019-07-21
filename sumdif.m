close all;
clc;
clear;

%% leer archivos
if ispc
    d='\';
else
    d='/';
end

pht1 = [pwd d , 'imas', d];
fl1=dir([pht1  '*.gif']);
nIm=length(fl1);
dir = [0 1;-1 1; -1 0;-1 -1];

%% For SDH Feacture Matrix
Window_width = [3 5 7 9 11 13 15 17 19 21 23 25];
Wave_Number = 5;
Points_Number = 50;
Windows_Number=length(Window_width);
SDH_feature_matrix = double(zeros(nIm*Points_Number,(length(Window_width))*Wave_Number));

for i1=1:nIm
    im = imread([pht1 fl1(i1).name]);
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
            Correlation_Feature = fcorrelation(sumImg,diffImg);
            Contrast_Feature = fcontrast(diffImg);
            Homogeneity_Feature = fhomogeneity(diffImg);
            CluserShade_Feature = fCShade(sumImg);
            ClusterProminece_Feature = fCProminece(sumImg);
            
            SDH_feature_matrix(Points_Number*(i1-1)+i3,(i2-1)*5+1:(i2-1)*5+5) = [Correlation_Feature,Contrast_Feature,Homogeneity_Feature,CluserShade_Feature,ClusterProminece_Feature];
        end
    end
end