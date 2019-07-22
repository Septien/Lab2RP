close all;
clc;
clear all;
%% leer archivos
if ispc
    d='\';
else
    d='/';
end

pht1 = [pwd d , 'imas', d];
fl1=dir([pht1  '*.gif']);
nIm=length(fl1);
%% For the gray-level covariance matrix
            % 0º 45º   90º   135º
dir1GLCM = [0 1; -1 1; -1 0; -1 -1]; % at distance 1
dir2GLCM = [0 2; -2 2; -2 0; -2 -2]; % at distance 2
dir3GLCM = [0 3; -3 3; -2 0; -3 -3]; % at distance 3
dir4GLCM = [0 4; -4 4; -4 0; -4 -4]; % at distance 4
dir5GLCM = [0 5; -5 5; -5 0; -5 -5]; % at distance 5
%% For the gray-level run lenght matrix
          %0º, 45º, 90º
dirGLRL = [1 2 3];
glcm = zeros(8, 8, 20);
J = zeros(1, 20);
glcmProps = zeros(nIm, 100);
glrlProps = double(zeros(nIm, 9));

for i1=1:nIm
    im = imread([pht1 fl1(i1).name]);
    % Compute the gray-level correlation matrix
    glcm(:, :, 1:4) = graycomatrix(im, 'NumLevels', 8, 'Offset', dir1GLCM);
    glcm(:, :, 5:8) = graycomatrix(im, 'NumLevels', 8, 'Offset', dir2GLCM);
    glcm(:, :, 9:12) = graycomatrix(im, 'NumLevels', 8, 'Offset', dir3GLCM);
    glcm(:, :, 13:16) = graycomatrix(im, 'NumLevels', 8, 'Offset', dir4GLCM);
    glcm(:, :, 17:20) = graycomatrix(im, 'NumLevels', 8, 'Offset', dir5GLCM);
    % Get its statistics
    for j = 1 : 20
        J(:, j) = entropy(glcm(:, :, j));
    end
    props = graycoprops(glcm);
    % Store
    glcmProps(i1, :) = [props.Correlation, props.Contrast, props.Homogeneity, props.Energy, J];
    
    % Compute the gray-level run length
    glrl = grayrlmatrix(im, 'NumLevels', 8, 'Offset', dirGLRL');
    glrlPropsA = grayrlprops(glrl);
    glrlProps(i1, :) = [glrlPropsA(1, 1:3), glrlPropsA(2, 1:3), glrlPropsA(3, 1:3)];
end
%%
percentage = 1;
[coeffglcm,glcmPropsPCA,latentglcm,tsquaredglcm,explainedglcm] = pca(glcmProps', 'NumComponents', nIm * percentage);%Datos nuevos extraidos del PCA
[coeffglrl,glrlPropsPCA,latentglrl,tsquaredglrl,explainedglrl] = pca(glrlProps', 'NumComponents', nIm * percentage);%Datos nuevos extraidos del PCA

