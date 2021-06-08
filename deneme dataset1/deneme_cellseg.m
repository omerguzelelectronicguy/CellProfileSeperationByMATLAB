function results = deneme_cellseg(im)
g = double(im); % Normalized Image
n = double(im.*2);
c = 0.20; % Constant
l = c*log(1 + (g)); % Log Transform
a= edge(l,'Canny',0.15,3);
b=edge(l,'Canny');
im = medfilt2(im, [7 7]);



results.l =l;
results.n =n;
results.g =g;
results.a =a;
results.b =b;

I_eq = adapthisteq(im);
bw = im2bw(I_eq, graythresh(I_eq));
bw2 = imfill(bw,'holes');
bw3 = imopen(bw2, ones(5,5));
bw4 = bwareaopen(bw3, 20);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(I_eq, bw4_perim, [.5 1 .2]);
mask_em = imextendedmax(I_eq, 12);
mask_em = imclose(mask_em, ones(5,5));
mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 20);
overlay2 = imoverlay(I_eq, bw4_perim | mask_em, [.3 1 .3]);
I_eq_c = imcomplement(I_eq);
I_mod = imimposemin(I_eq_c, ~bw4 | mask_em);
L = watershed(I_mod);
rgb =label2rgb(L);
s  = regionprops(L, 'basic');
centroids = cat(1, s.Centroid);
imshow(l)
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off


results.ol =overlay2;
results.L =I_mod;
results.rgb =rgb;
results.masked =imextendedmax(I_eq, 5);
results.imm =im;

%-------------

[row, col] = find(all(im == permute([0 0 255], [1 3 2]), 3));

%--------------------------------------------------------------------------
