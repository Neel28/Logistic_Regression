function [normData] = featureNormalize(data)
normData = zeros(size(data,1),size(data,2));
mu = mean(data);
sigma = std(data);
mu(1) = 0;
sigma(1) = 1;
for row = 1:size(data,1)
    for col = 1:size(data,2)
        if sigma(col)==0
            normData(row,col) = 0;
        else
            normData(row,col) = (data(row,col)-mu(col))/sigma(col);
        end
    end
end

end