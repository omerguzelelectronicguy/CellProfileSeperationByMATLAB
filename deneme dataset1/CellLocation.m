function cellLocs = CellLocation(rgbvalues, im)
[m n]=size(rgbvalues(:,1));
A = [0 0];
for i=1:m
    [row, col] = find(all(im == permute([rgbvalues(m,1) rgbvalues(m,2) rgbvalues(m,3)], [1 3 2]), 3));
    A = [A; row col];
end
cellLocs = A;