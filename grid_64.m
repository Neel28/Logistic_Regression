function g = grid_64(b,s)

l = size(b,1);
g=zeros(l,64);

for row=1:l
    b1=find(b(row,:)==1);
    s1=find(s(row,:)==1);
    
    if s1==1
        put=b1;
        g(row,b1)=1;
    else
        put=(s1-1)*8 + b1;
        g(row,put)=1;
    end
end

end