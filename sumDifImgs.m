function [sumImg, diffImg] = sumDifImgs(img)
    [rows, cols, ch] = size(img);
    diffImg = zeros(rows, cols);
    sumImg = zeros(rows, cols);
    
    for i = 1 : rows
        for j = 1 : cols - 1
            diffImg(i, j) = img(i, j) - img(i, j + 1);
            sumImg(i, j) = img(i, j) + img(i, j + 1);
        end
    end
end
