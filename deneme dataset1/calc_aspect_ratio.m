function a_ratio=calc_aspect_ratio(arr)
xg=mean(arr(:,1));
yg=mean(arr(:,2));
%the mass center is xg,yg
distances=(arr(:,1)-xg).^2+(arr(:,2)-yg).^2;
a_ratio=max(distances)/min(distances);
a_ratio=sqrt(a_ratio);
end