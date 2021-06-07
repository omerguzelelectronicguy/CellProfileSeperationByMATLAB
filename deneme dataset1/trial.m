k=size(RGBVal,1);
std_values=zeros(k,1);
av_values=zeros(k,1);
hold on;
for i=1:k
    [xg,yg,sc]=CellLocation(RGBVal(i,:),re.rgb,imadjust(im));
    std_values(i)=std(double(sc));
    av_values(i)=mean(double(sc));
    
    plot(xg,yg, 'r*')
end
features=[std_values av_values];