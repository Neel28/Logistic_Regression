function [ans,th] = icv_regularization(xtr,ytr,xte,yte,lambda)
k=3;
indices = crossvalind('Kfold',ytr,k);
disp('#####################');
indices;
tr_accu=0;
val_accu=0;
te_accu=0;
acc=0;
grid = xtr;
for i=1:k
    val=0;
    train=0;
    dtrain=0;
    ltrain=0;
    dval=0;
    lval=0;
    
    val = (indices == i); 
    train = ~val;
    dtrain = xtr(train,:);
    ltrain = ytr(train,:);
    dval = xtr(val,:);
    lval = ytr(val,:);
    
    initial_theta = zeros(size(xtr,2),1);
    %theta = glmfit(dtrain,ltrain,'normal','constant','off')+e-02;
    initial_theta;
    alpha=0.0001;
    [theta,cost_history,counter,accu_plot] = ibatchGD_regularization(dtrain,ltrain,initial_theta,alpha,0,lambda,grid);
    tr_accu = tr_accu + accu_q4(dtrain,ltrain,theta);
    val_accu = val_accu + accu_q4(dval,lval,theta);
    te_accu = te_accu + accu_q4(xte,yte,theta);
    
    if val_accu>acc
        acc=val_accu;
        th=theta;
    end
end
tr_accu = tr_accu/k;
val_accu = val_accu/k;
te_accu = te_accu/k;
ans = [tr_accu,val_accu,te_accu];
end