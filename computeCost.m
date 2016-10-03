
function cost = computeCost(x,y,theta)

m=length(y);
htheta = sigmoid(x*theta);
cost = sum(-y .* log(htheta) - (1-y) .* log(1-htheta))/m;

%{
m=size(y,1);
sum=0;
for col=1:m
    a=0;
    b=0;
    if y(col,1)==1
        a=-y(col,1) * log(htheta(col,1));
    elseif y(col,1)==0
        b=(1-y(col,1)) .* log(1-htheta(col,1));
    else
        a=-y(col,1) * log(htheta(col,1));
        b=(1-y(col,1)) .* log(1-htheta(col,1));
    end
    sum=sum+a-b;
end
%}

end