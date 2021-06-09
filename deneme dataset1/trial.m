clc; clear;
im = imread('ADSASS092408-GHAD2-D6-20x_A01_s2_w102757319-E524-42CB-9884-F1608FFBD7EF.png');
imorigin=im;
im=imadjust(im,[10/255 70/255]);
im=imsharpen(im);
%re = deneme_cellseg(im,0.15,25);%  this is for labeled image.
re = deneme_cellseg(im,0.12,35); %  this is for other images.
rgb_val=RGBval(re.rgb);

k=size(rgb_val,1);
std_values=zeros(k,1);
av_values=zeros(k,1);
pos=zeros(k,2);
lab=zeros(k,1);
pos_in_rgbval=zeros(k,1);
std_of_hist_values=zeros(k,1);

for i=1:k
    [xg,yg,sc]=CellLocation(rgb_val(i,:),re.rgb,im);
       len(i)=length(sc);

    if length(sc)>200 & length(sc)<5000
        pos_in_rgbval(i)=i;
        pos(i,:)=[xg yg];
        std_values(i)=std(double(sc));
        av_values(i)=mean(double(sc));
        std_of_hist_values(i)=std(imhist(sc,255));
    end
end
rgb_val=rgb_val(find(pos_in_rgbval~=0),:);
figure;imshow((im));% use imorigin instead of im for labeled images.
hold on;
for i=1:k
    if  std_values(i)> 8
        plot(pos(i,1),pos(i,2), 'g*');
        lab(i)=1;
    else
        plot(pos(i,1),pos(i,2), 'r*');
        lab(i)=0;
    end
end

figure;imshow(re.rgb)
sum(lab)
features=[std_values av_values lab];