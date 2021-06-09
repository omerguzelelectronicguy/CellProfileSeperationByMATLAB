% clc; clear;
% load('theta_params.mat');
% im = imread('ADSASS092408-GHAD2-D6-20x_A01_s2_w102757319-E524-42CB-9884-F1608FFBD7EF.png');
% im=imread('E01_s8.png');
% imorigin=im;
% im=rgb2gray(imorigin);
% %im=imadjust(im,[10/255 80/255]);
% re = deneme_cellseg(im);
% rgb_val=RGBval(re.rgb);

k=size(rgb_val,1);
std_values=zeros(k,1);
av_values=zeros(k,1);
pos=zeros(k,2);
lab=zeros(k,1);
std_of_hist_values=zeros(k,1);

for i=1:k
    [xg,yg,sc]=CellLocation(rgb_val(i,:),re.rgb,im);
    pos(i,:)=[xg yg];
    std_values(i)=std(double(sc));
    av_values(i)=mean(double(sc));
    std_of_hist_values(i)=std(imhist(sc,255));
end

figure;imshow((im));
hold on;
for i=1:k
    if  std_values(i)> 18
        plot(pos(i,1),pos(i,2), 'g*');
        lab(i)=1;
    else
        plot(xg,yg,'r*')
    end
end
    
figure;imshow(re.rgb)
sum(lab)
features=[std_values av_values lab];
