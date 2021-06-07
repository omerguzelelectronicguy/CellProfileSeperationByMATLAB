function [xg, yg, sampleCell] = CellLocation(rgbvalue, imrgb,im)
[row, col] = find(all(imrgb == permute([rgbvalue], [1 3 2]), 3));
sampleCell = im(size(im,1)*(col-1)+row);
xg=mean(double(col));
yg=mean(double(row));