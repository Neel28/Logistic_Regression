function [d1,d2,d3,l1,l2,l3] = make(x1_tr,x2_tr,x3_tr,label_test,p)

len = size(x1_tr,1);
r = randperm(len);
for row=1:(p*10)
    d1(row,1) = x1_tr(r(1,row),1);
    d1(row,2) = x1_tr(r(1,row),2);
    l1(row,1) = 1;
end

len = size(x2_tr,1);
r = randperm(len);
for row=1:(p*10)
    d2(row,1) = x2_tr(r(1,row),1);
    d2(row,2) = x2_tr(r(1,row),2);
    l2(row,1) = 2;
end

len = size(x3_tr,1);
r = randperm(len);
for row=1:(p*15)
    d3(row,1) = x3_tr(r(1,row),1);
    d3(row,2) = x3_tr(r(1,row),2);
    l3(row,1) = 3;
end

end