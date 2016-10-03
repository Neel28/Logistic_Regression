function ans = accu_q4(x,y,theta)

htheta_test = sigmoid(x*theta);
p_test=zeros(size(x,1),1);
p_test = htheta_test >= 0.5;

accu_test=0;
for col=1:size(y,1)
    if p_test(col) == y(col)
        accu_test = accu_test+1;
    end
end
ans = (accu_test*100)/size(y,1);

end