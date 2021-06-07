function [r g b]=find_background(rgbim)
temp=imhist(rgbim(:,:,3));
[val b]=max(temp);
temp=imhist(rgbim(:,:,2));
[val g]=max(temp);
temp=imhist(rgbim(:,:,1));
[val r]=max(temp);
end