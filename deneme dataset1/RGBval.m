function RGBvaluesofImage = RGBval(im)
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);
[m,n]=size(r);
A = 1:3;
for i=1:m
    for j=1:n   
        if (r(i,j)==0)&&(g(i,j)==0)&&(b(i,j)==255)
            %nothing
        else
            p=0;
            [a_length a_width]=size(A(:,1));
            for k=1:a_length
                if (A(k,1)~=r(i,j)) || (A(k,2)~=g(i,j)) || (A(k,3)~=b(i,j))
                    %nothing 
                else
                    p=1;
                end
            end
            if p==0
                A = [A; r(i,j) g(i,j) b(i,j)];
            end
        end
    end
end
RGBvaluesofImage = A(3:end,:);



