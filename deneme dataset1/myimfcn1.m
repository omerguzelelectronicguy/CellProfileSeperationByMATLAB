function res=myimfcn1(im)
im = imread('ADSASS092408-GHAD2-D6-20x_A05_s4_w1AF7B7E9F-A764-4CFE-A534-114B81034801.png');
im=im(1:600,1:600);

imadj=imadjust(im,[15/255 70/255]);
imsha=imsharpen(imadj);

im(find(im<20))=0;
im2=double(im).^1.117;

im3=deconvblind(im2,[7 7]);
im4=edge(im3,'Canny');
im5=edge(im3,'Canny',0.2,3);
%imadjusta bir bak, 15den 70e güzel bir maske.

se90 = strel('line',5,5);
se0 = strel('line',5,5);
im6 = imdilate(im5,[se90 se0]);

im7=imfill(im6,'holes');

im8=-1*(grayconnected(im3,12,12,13)-1);

se = strel('disk',13);
im9 = imerode(im8,se);
imshowpair(im8,im9,'montage');
im10=boundarymask(im9);
figure;
%s = regionprops(im8,{'Centroid','MajorAxisLength','MinorAxisLength','Orientation'});
s  = regionprops(im10, 'basic');
centroids = cat(1, s.Centroid);
imshow(im8)
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off
cluster=3;
im11=255/3.*imsegkmeans(uint8(im3),cluster);

res.cent=centroids;
res.b=im;
res.c=im2;
res.d=im3;
res.e=im4;
res.f=im5;
res.g=im6;
res.h=im7;
res.i=im8;
res.j=im9;
res.k=im10;
res.l=im11;

end
% imbinarize da güzel bir kardeşimiz
%% Possible Alternative
% [centers, radii, metric] = imfindcircles(im3,[5 20]);
% centersStrong5 = centers(1:5,:);
% radiiStrong5 = radii(1:5);
% metricStrong5 = metric(1:5);
% imshow(im3,[0 255])
% hold on
% viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
%%
%------------- histeq yap - güzel olmadı.
% 
% X=g;
% rng(1); % For reproducibility
% [idx,C] = kmeans(X,3);
% x1 = min(X(:,1)):0.01:max(X(:,1));
% x2 = min(X(:,2)):0.01:max(X(:,2));
% [x1G,x2G] = meshgrid(x1,x2);
% XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot
% 
% idx2Region = kmeans(XGrid,2,'MaxIter',1);
% 
% figure;
% gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
%     [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
% hold on;
% plot(X(:,1),X(:,2),'k*','MarkerSize',5);
% title 'Fisher''s Iris Data';
% xlabel 'Petal Lengths (cm)';
% ylabel 'Petal Widths (cm)'; 
% legend('Region 1','Region 2','Region 3','Data','Location','SouthEast');
% hold off;