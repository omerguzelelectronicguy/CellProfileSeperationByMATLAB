function enh = enhanceim(im)

im = double(im);
im1 = 0.1*log(1 + (im));
im2 = adapthisteq(im1);
im3 = deconvblind(im2,[7 7]);

enh.im1=im1;
enh.im2=im2;
enh.im3=im3;

