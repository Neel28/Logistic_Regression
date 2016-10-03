function cost = icomputeCost_regularization(x,y,theta,lambda,grid)

b=reshape((1:1:64),8,[])'
m=length(y);
htheta = sigmoid(x*theta);

% neighbor regularization
s = 0;
if grid(1,1)~=0
    s = s+ (theta(1)-theta(9))^2 + (theta(1)-theta(2))^2;
end
if grid(1,8)~=0
    s = s+ (theta(8)-theta(16))^2 + (theta(8)-theta(7))^2;
end
if grid(8,8)~=0
    s = s+ (theta(64)-theta(63))^2 + (theta(64)-theta(56))^2;
end
if grid(8,1)~=0
    s = s+ (theta(57)-theta(49))^2 + (theta(57)-theta(58))^2
end
for i=2:7
    if grid(1,i)~=0
        s = s+ (theta(i)-theta(i+1))^2 + (theta(i)-theta(i-1))^2
    end
end
for i=2:7
    if grid(8,i)~=0
        s = s+ (theta(i+56)-theta(i+1+56))^2 + (theta(i+56)-theta(i-1+56))^2;
    end
end
for i=2:7
    if grid(i,1)~=0
        s = s+ (theta(b(i,1))-theta(b(i-1,1)))^2 + (theta(b(i,1))-theta(b(i+1,1)))^2;
    end
end
for i=2:7
    if grid(i,8)~=0
        s = s+ (theta(b(i,8))-theta(b(i-1,8)))^2 + (theta(b(i,8))-theta(b(i+1,8)))^2;
    end
end
for i=2:7
    for j=2:7
        if grid(i,j)==1
            s = s+ (theta(b(i,j))-theta(b(i-1,j)))^2; 
            s = s+ (theta(b(i,j))-theta(b(i+1,j)))^2;
            s = s+ (theta(b(i,j))-theta(b(i,j-1)))^2; 
            s = s+ (theta(b(i,j))-theta(b(i,j+1)))^2; 
    end
end
%

cost = sum(-y .* log(htheta) - (1-y) .* log(1-htheta))/m + (0.5*lambda*s);

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