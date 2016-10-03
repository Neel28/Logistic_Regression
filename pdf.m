function res_test = pdf(data_test, pi1,pi2,pi3,mu1,mu2,mu3,cov1,cov2,cov3)

res_test = zeros(size(data_test,1),1);
p = zeros(1,3);
for row=1:length(data_test)
    p(1,1) = pi1*(1/(2*pi*det(cov1)))*exp((-0.5)*(data_test(row,:)'-mu1)'*inv(cov1)*(data_test(row,:)'-mu1));
    p(1,2) = pi2*(1/(2*pi*det(cov2)))*exp((-0.5)*(data_test(row,:)'-mu2)'*inv(cov2)*(data_test(row,:)'-mu2));
    p(1,3) = pi3*(1/(2*pi*det(cov3)))*exp((-0.5)*(data_test(row,:)'-mu3)'*inv(cov3)*(data_test(row,:)'-mu3));
    [m i] = sort(p);
    res_test(row,1) = i(3);
end
end