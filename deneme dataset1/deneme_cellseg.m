function results = deneme_cellseg(im,val_1,val_2)
%im=im(1:500,1:500,:);
im = medfilt2(im, [5 5]);

I_eq = adapthisteq(im); %
bw = im2bw(I_eq, graythresh(I_eq)-val_1);

bw3 = imopen(bw, ones(3,3)); %open image morphologically
bw4_perim = bwperim(bw3);  %find perimeters of objects 
overlay1 = imoverlay(I_eq, bw4_perim , [.5 1 .2]); %not necessary now

mask_em = imextendedmax(I_eq, val_2);
mask_em = imclose(mask_em, ones(5,5));

mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 20);

I_eq_c = imcomplement(I_eq); % computes the complement of the image 
I_mod = imimposemin(I_eq_c, ~bw3 | mask_em);
L = watershed(I_mod);
rgb =label2rgb(L);

results.ol =overlay1;
results.L =I_mod;
results.rgb =rgb;
results.masked =imextendedmax(I_eq, 5);
results.imm =I_eq;
end
