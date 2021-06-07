function [row col]=find_loc(im,val)
[row col]=find(im(:,:,3)==val);
end