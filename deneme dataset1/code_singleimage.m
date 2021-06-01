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


%-------------

X=l;
[xx,yy] = size(X);
for i=1:xx
    for j = 1:yy
        if X(i,j) < 1.20
            X(i,j)=0;
        end
    end
end

figure
imshow(n, [0 255])

figure
surf(X);xlabel('x axis');ylabel('y axis');zlabel('intensity');
hold on 
image(X,'CDataMapping','scaled')

rng(1); % For reproducibility
[idx,C] = kmeans(X,8);
