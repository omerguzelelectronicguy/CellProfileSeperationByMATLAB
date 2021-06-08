clc; clear;
im = imread('ADSASS092408-GHAD2-D6-20x_A01_s2_w102757319-E524-42CB-9884-F1608FFBD7EF.png');
%im=imread('E01_s8.png');
imorigin=im;
%im=rgb2gray(imorigin);
im=imadjust(im,[10/255 80/255]);
re = deneme_cellseg(im);
rgb_val=RGBval(re.rgb);

k=size(rgb_val,1);
std_values=zeros(k,1);
av_values=zeros(k,1);
lab=zeros(k,1);

figure;imshow((im));
hold on;
for i=1:k
    [xg,yg,sc]=CellLocation(rgb_val(i,:),re.rgb,imadjust(im));
    std_values(i)=std(double(sc));
    av_values(i)=mean(double(sc));
    if std_values(i)>17
        plot(xg,yg, 'g*')
        lab(i)=1;
    else
        plot(xg,yg,'r*')
        lab(i)=0;
    end
end
figure;imshow(re.rgb)
sum(lab)
features=[std_values av_values lab];