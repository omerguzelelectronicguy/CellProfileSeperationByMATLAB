im = imread('ADSASS092408-GHAD2-D6-20x_A05_s4_w1AF7B7E9F-A764-4CFE-A534-114B81034801.png');
g = double(im); % Normalized Image % Normalized Image
c = 0.40; % Constant
l = c*log(1 + (g)); % Log Transform
a= edge(l,'Canny',0.2,3);
b=edge(l,'Canny');




%-------------

X=g;
rng(1); % For reproducibility
[idx,C] = kmeans(X,3);
x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

idx2Region = kmeans(XGrid,3,'MaxIter',1);

figure;
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)';
ylabel 'Petal Widths (cm)'; 
legend('Region 1','Region 2','Region 3','Data','Location','SouthEast');
hold off;