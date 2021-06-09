function results = deneme_cellseg(im)
im=im(640:1040,992:1392,:);%400*400
im = medfilt2(im, [5 5]);

I_eq = adapthisteq(im); %
bw = im2bw(I_eq, graythresh(I_eq)-0.07);

bw3 = imopen(bw, ones(3,3)); %open image morphologically
bw4_perim = bwperim(bw3);  %find perimeters of objects 
overlay1 = imoverlay(I_eq, bw4_perim , [.5 1 .2]); %not necessary now

mask_em = imextendedmax(I_eq, 35);
mask_em = imclose(mask_em, ones(5,5));
I_eq_c = imcomplement(I_eq); % computes the complement of the image 
I_mod = imimposemin(I_eq_c, ~bw3 | mask_em);
L = watershed(I_mod);
rgb =label2rgb(L);

results.ol =overlay1;
results.impose =I_mod;
results.rgb =rgb;
results.masked =imextendedmax(I_eq, 17);
results.L =L;
end
