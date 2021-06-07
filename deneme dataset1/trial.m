clc; clear;
im = imread('ADSASS092408-GHAD2-D6-20x_A01_s2_w102757319-E524-42CB-9884-F1608FFBD7EF.png');
im=im(1:400,1:400);
re = deneme_cellseg(im);
rgb_val=RGBval(re.rgb);
figure;imshow(re.rgb);

k=size(rgb_val,1);
std_values=zeros(k,1);
av_values=zeros(k,1);
hold on;
for i=1:k
    [xg,yg,sc]=CellLocation(rgb_val(i,:),re.rgb,imadjust(im));
    std_values(i)=std(double(sc));
    av_values(i)=mean(double(sc));
    
    plot(xg,yg, 'r*')
end
features=[std_values av_values];