function spam_main()
load spambase;

spam_data =  spambase(randperm(end),:);

spam_train = spam_data(1:2301,1:57);
spam_test = spam_data(2302:end,1:57);

label_train = spam_data(1:2301,58);
label_test = spam_data(2302:end,58);

[x1,y1] = size(spam_train);
[x2,y2] = size(spam_test);
spam_train=[ones(x1,1) spam_train];
spam_test=[ones(x2,1) spam_test];

norm_train = featureNormalize(spam_train);
norm_test = featureNormalize(spam_test);
norm_data = [norm_train;norm_test];

%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Batch Gradient Descent, Raw data
initial_theta = zeros(size(spam_train,2),1);
alpha = 0.0001;
[theta_batchGD_raw, cost_batchGD_raw,counter_batchGD_raw,a1] = batchGD(spam_train,label_train,initial_theta,alpha,1,spam_train);
%plot((1:2:counter_batchGD_raw),a1(1:2:end))
%xlabel('No.of iterations') % x-axis label
%ylabel('Accuracy of training data') % y-axis label
disp('accuracy = ')
acc1 = accu_q4(spam_test,label_train,theta_batchGD_raw)

initial_theta = zeros(size(norm_train,2),1);
alpha = 0.0001;
[theta_batchGD_norm, cost_batchGD_norm,counter_batchGD_norm,a2] = batchGD(norm_train,label_train,initial_theta,alpha,0,spam_train);
%plot((1:1:counter_batchGD_norm),a2)
%xlabel('No.of iterations') % x-axis label
%ylabel('Accuracy of training data') % y-axis label
%plot((1:1:counter_batchGD_norm-1),cost_batchGD_raw)
%xlabel('No.of iterations') % x-axis label
%ylabel('Cost Function') % y-axis label
disp('Accuracy = ')
acc2 = accu_q4(spam_test,label_train,theta_batchGD_norm)
%
alpha = 0.0001;
initial_theta = zeros(size(spam_train,2),1);
[theta_newton_raw, cost_newton_raw,counter_newton_raw,a3] = newton(spam_train,label_train,initial_theta,alpha,1,spam_train);
%plot((1:1:counter_batchGD_norm-1),a3)
%xlabel('No.of iterations') % x-axis label
%ylabel('Accuracy of training data') % y-axis label
disp('$$$$$$$$$$$$$$$')
acc3 = accu_q4(spam_test,label_train,theta_newton_raw)

alpha = 0.0001;
initial_theta = zeros(size(norm_train,2),1);
[theta_newton_norm, cost_newton_norm,counter_newton_norm,a4] = newton(norm_train,label_train,initial_theta,alpha,0,spam_train);
%plot((1:1:counter_newton_norm),a4)
%plot((1:1:counter_newton_norm-1),cost_newton_norm)
xlabel('No.of iterations') % x-axis label
ylabel('Accuracy of training data') % y-axis label
disp('$$$$$$$$$$$$$$$')
acc4 = accu_q4(spam_test,label_train,theta_newton_norm)
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% glmfit , norm data
theta_glm_norm = glmfit(norm_train,label_train,'normal');
pred_glm_norm = glmval(theta_glm_norm,spam_test,'identity');
p = pred_glm_norm >= 0.5;

accu=0;
for col=1:size(label_test,1)
    if p(col) == label_test(col)
        accu = accu+1;
    end
end
disp(' glmfit accuracy = ')
accu_glm_norm_b = (accu*100)/size(label_test,1)

%glmfit , raw data
theta_glm_raw = glmfit(spam_train,label_train,'normal');
pred_glm_raw = glmval(theta_glm_raw,spam_test,'identity');
p = pred_glm_raw >= 0.5;

accu=0;
for col=1:size(label_test,1)
    if p(col) == label_test(col)
        accu = accu+1;
    end
end
disp('glmfit accuracy = ')
accu_glm_raw_b = (accu*100)/size(label_test,1)

%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Fetaure Analysis
p = convertBin(spambase(:,1:57),spambase(:,58));

px = 460.0/size(spambase,1);
class_0 = length(find(spambase(:,58)==0));
class_1 = length(find(spambase(:,58)==1));
pClass_0 = class_0/size(spambase,1);
pClass_1 = class_1/size(spambase,1);
mi = zeros(57,1);

for feature=1:57
    m = 0;
    
    %pxy0 = (p{1,feature}(:,1)./46000).*log((p{1,feature}(:,1)./46000)./(px*pClass_0));
    %pxy1 = (p{1,feature}(:,2)./46000).*log((p{1,feature}(:,2)./46000)./(px*pClass_1));
    
    for bins=1:10
        m = m + ((p{1,feature}(bins,1)/4601)*log((p{1,feature}(bins,1)/4601)/(px*pClass_0))) + ((p{1,feature}(bins,2)/4601)*log((p{1,feature}(bins,2)/4601)/(px*pClass_1)));
         
    end
    
    mi(feature,1) = m;
    
end
disp('Mutual Information values = ')
mi
%}
%plot((1:1:57),mi)
%xlabel('Features')
%ylabel('Mutual Information')
%
% pcc
pcc = zeros(57,1);
for feature=1:57
    sxy = sum(spambase(:,feature).*spambase(:,58));
    sx = sum(spambase(:,feature));
    sy = sum(spambase(:,58));
    sx2 = sum(spambase(:,feature).^2);
    sy2 = sum(spambase(:,58).^2);
    
    pcc(feature,1) = (4601*sxy - sx*sy)/sqrt((4601*sx2 - sx^2)*(4601*sy2 - sy^2)); 
end
disp('Pearson Correlation Coefficient = ')
pcc
%plot((1:1:57),pcc)
%xlabel('Features')
%ylabel('PCC')
%}

%
% part e
[mi_sort,feature] = sort(mi,'descend');
disp('Top 20 feature IDs with repect to MIs')
feature(1:20,:)
tr_data = zeros(4601,21);
tr_data = spambase(:,feature(1,1));
for i=2:20
    tr_data = [tr_data,spambase(:,feature(i,1))];
end
tr_data = [tr_data,spambase(:,58)];

t_data =  tr_data(randperm(end),:);
d_train = t_data(1:2301,1:20);
d_test = t_data(2302:end,1:20);
l_train = t_data(1:2301,21);
l_test = t_data(2302:end,21);

n_tr = featureNormalize(d_train);
n_te = featureNormalize(d_test);

theta_glm = glmfit(n_tr,l_train,'normal');
pred_glm = glmval(theta_glm,n_te,'identity');
p = pred_glm >= 0.5;

accu=0;
for col=1:size(l_test,1)
    if p(col) == l_test(col)
        accu = accu+1;
    end
end
disp('unbinarised testing accuracy = ')
accu_glm = (accu*100)/size(l_test,1)

theta_glm = glmfit(n_tr,l_train,'normal');
pred_glm = glmval(theta_glm,n_tr,'identity');
p = pred_glm >= 0.5;

accu=0;
for col=1:size(l_train,1)
    if p(col) == l_train(col)
        accu = accu+1;
    end
end
disp('unbinarised train accuracy = ')
accu_glm = (accu*100)/size(l_train,1)

pcc_abs = abs(pcc);
mi_pcc = pcc_abs(feature);
mi_pcc = mi_pcc(1:20,1);
[sort_pcc,i] = sort(mi_pcc);
f=zeros(3,1);
f = [feature(i(1,1),1);feature(i(2,1),1);feature(i(3,1),1)];
disp('Fetaure IDs among above 20 features having lowest |PCC| = ')
f
t_data =  spambase(randperm(end),:);
t = featureNormalize(t_data(:,1:57));
t_data = [t,t_data(:,58)];
d_train = t_data(1:2301,f);
d_test = t_data(2302:end,f);
l_train = t_data(1:2301,58);
l_test = t_data(2302:end,58);

f1 = grid_data(d_train(:,1));
f2 = grid_data(d_train(:,2));
f3 = grid_data(d_train(:,3));

main_data = [f1,f2,f3];

for j=1:20
    col = feature(j,1);
    if col~= f(1,1) && col~= f(2,1) && col~= f(3,1)
        main_data = [main_data,t_data(1:2301,col)];
    end
end

f1 = grid_data(d_test(:,1));
f2 = grid_data(d_test(:,2));
f3 = grid_data(d_test(:,3));
test_data = [f1,f2,f3];
for j=1:20
    col = feature(j,1);
    if col~= f(1,1) && col~= f(2,1) && col~= f(3,1)
        test_data = [test_data,t_data(2302:end,col)];
    end
end


theta_glm_bin = glmfit(main_data,l_train,'normal');
pred_glm = glmval(theta_glm_bin,test_data,'identity');
p = pred_glm >= 0.5;

accu=0;
for col=1:size(l_test,1)
    if p(col) == l_test(col)
        accu = accu+1;
    end
end
disp('Binarised accuracy on test data = ')
accu_glm_bin = (accu*100)/size(l_test,1)

theta_glm_bin = glmfit(main_data,l_train,'normal');
pred_glm = glmval(theta_glm_bin,main_data,'identity');
p = pred_glm >= 0.5;

accu=0;
for col=1:size(l_train,1)
    if p(col) == l_train(col)
        accu = accu+1;
    end
end
disp('Binarised accuracy on train data = ')
accu_glm_bin = (accu*100)/size(l_train,1)
%}


end










