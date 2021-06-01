clear; clc; 
im = imread('ADSASS092408-GHAD2-D6-20x_A05_s4_w1AF7B7E9F-A764-4CFE-A534-114B81034801.png');
im=im(1:200,1:300);

g = double(im); % Normalized Image % Normalized Image
n = double(im.*2);
c = 0.40; % Constant
l = c*log(1 + (g)); % Log Transform
a= edge(n,'Canny',0.2,3);
b=edge(n,'Canny');


results.l =l;
results.n =n;
results.g =g;
results.a =a;
results.b =b;

f1 = imfill(a,'holes');
se = strel('line',11,90);
se0 = strel('line',11,0);

d1 = imdilate(a,se);
e = imerode(BWdil,se);
f2 = imfill(erodeBW, 'holes');

results.d1 =d1;
results.e =e;
results.f2 =f2;
results.f1 =f1;

%-------------
