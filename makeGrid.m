function [data,i] = makeGrid(n,xTr_1)

x = linspace(-2,2,n+1);
y = linspace(-2,2,n+1);

i = zeros(size(xTr_1,2));

for row=1:size(xTr_1,1)
    freq = zeros(1,n+1);
    freq = histc(xTr_1(row,1),x);
    index1 = find(freq==1);
    if row==1
        freq
        index1
    end
    if index1 == n+1
        index1 = n-1;
        
    end
    
    freq = zeros(1,n+1);
    freq = histc(xTr_1(row,2),y);
    index2 = find(freq==1);
    if index2 == n+1
        index2 = n-1;
    end
    
    i(row,1) = index1;
    i(row,2) = index2;
end

data = zeros(size(xTr_1,1),n*n);
for row=1:size(xTr_1,1)
    if i(row,2)==1
        col = i(row,1);
    else 
        col = (i(row,2)-1)*n + i(row,1);
    end
    data(row,col) = 1;
end

end






