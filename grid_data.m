function g = grid_data(data);
g = zeros(length(data),3);

ma = max(data);
mi = min(data);

v = linspace(mi,ma,4);

for row=1:length(data)
    if data(row,1)>=v(1) && data(row,1)<v(2)
        g(row,1)=1;
    elseif data(row,1)>=v(2) && data(row,1)<v(3)
        g(row,2)=1;
    else
        g(row,3)=1;
    end
end