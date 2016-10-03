function g = toy_grid(data,n);

g = zeros(size(data,1),n);
v = linspace(-2,2,(n+1));
v;
% ||| ||||| |||||||||

for row=1:length(data)
    freq = histc(data(row,1),v);
    index = find(freq==1);
    if index==length(v) || index==length(v)-1
        g(row,n) = 1;
    else
        g(row,index)=1;
    end
end

end