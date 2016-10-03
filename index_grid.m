function g = index_grid(c1,c2)
size(c1)
size(c2)
g=cell(8);

for sample=1:size(c1,1)
    j = find(c1(sample,:)==1);
    i = find(c2(sample,:)==1);
    g{i,j}=[g{i,j},sample];
end

end