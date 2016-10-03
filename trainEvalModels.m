function [res_test,accuracy_final] = trainEvalModels()
load toyGMM.mat    
load x1_tr
load x2_tr
load x3_tr
load data_train
load data_test
load label_test
load label_train
    %% MLE learning of model1, Gaussian Discriminative Analysis I
    % your code here
    mu1 = mean(x1_tr);
    mu1 = mu1';
    pi1 = length(x1_tr)/length(data_train);
    cov1 = cov(x1_tr);
    % acc1 = ...;
    
    %% MLE learning of model2, Gaussian Discriminative Analysis II
    mu2 = mean(x2_tr);
    mu2 = mu2';
    pi2 = length(x2_tr)/length(data_train);
    cov2 = cov(x2_tr);
    % your code here
    
    %% learning of model3, the MLR classifeir
    mu3 = mean(x3_tr);
    mu3 = mu3';
    pi3 = length(x3_tr)/length(data_train);
    cov3 = cov(x3_tr);
    % your code here
    
    %% visualize and compare learned models
    % plotBoarder(model1, model2, model3, dataTe)
    
    %% Multinomial Logistic Distribution
    para = mnrfit(data_train , label_train);
    para = [para,zeros(length(para),1)];
    para;
    pihat = mnrval(para , data_test);
    [prob,res] = max(pihat,[],2);
    accu = 0;
    for row = 1:size(label_test,1)
        if res(row,1) == label_test(row,1)
            accu = accu+1;
        end
    end
    result = accu*100 / size(label_test,1)
    % 
    
   % accuracy of test data , independent s1 s2 s3
   res_test = pdf(data_test, pi1,pi2,pi3,mu1,mu2,mu3,cov1,cov2,cov3);
   accu = 0;
   for row=1:length(label_test)
       if label_test(row,1) == res_test(row,1)
           accu = accu+1;
       end
   end
   accu_test = accu*100 / length(data_test)
   pi1
   pi2
   pi3
   mu1
   mu2
   mu3
   cov1
   cov2
   cov3
   
   %
   
   %accuracy of test data, s1=s2=s3
   c = ((cov1*length(x1_tr))+(cov2*length(x2_tr))+(cov3*length(x3_tr)))/(length(x1_tr)+length(x2_tr)+length(x3_tr))
   res_test = pdf(data_test, pi1,pi2,pi3,mu1,mu2,mu3,c,c,c);
   accu = 0;
   for row=1:length(label_test)
       if label_test(row,1) == res_test(row,1)
           accu = accu+1;
       end
   end
   accu_test = accu*100 / length(data_test)
   %
     
    %% visualize and compare learned models
    %
    pi = [pi1;pi2;pi3];
    model1.pi=pi;
    model1.m1=mu1';
    model1.m2=mu2';
    model1.m3=mu3';
    model1.S1=cov1;
    model1.S2=cov2;
    model1.S3=cov3;
    
    model2.pi=pi;
    model2.m1=mu1';
    model2.m2=mu2';
    model2.m3=mu3';
    model2.S1=c;
    model2.S2=c;
    model2.S3=c;
    
    model3.w=para;
    %}
    plotBoarder(model1, model2, model3, dataTe)
       
    %% Part e
    %
    perc = [1,5,10,25,50,100];
    pl = zeros(1,6);
    p2 = zeros(1,6);
    p3 = zeros(1,6);
    accuray_final = zeros(3,size(perc,2));
    for i=1:size(perc,2)
        [d1,d2,d3,l1,l2,l3] = q4_2e(x1_tr,x2_tr,x3_tr,label_test,perc(1,i));
        l=length(d1)+length(d2)+length(d3);
        
        m1 = mean(d1);
        m1 = m1';
        p1 = length(d1)/l;
        c1 = cov(d1);
        
        m2 = mean(d2);
        m2 = m2';
        p2 = length(d2)/l;
        c2 = cov(d2);
        
        m3 = mean(d3);
        m3 = m3';
        p3 = length(d3)/l;
        c3 = cov(d3);
        
        % accuracy of test data , independent s1 s2 s3
        res_test = pdf(data_test, p1,p2,p3,m1,m2,m3,c1,c2,c3);
        accu = 0;
        for row=1:length(label_test)
            if label_test(row,1) == res_test(row,1)
                accu = accu+1;
            end
        end
        accuracy_final(1,i) = accu*100 / length(data_test)
        %
        %accuracy of test data, s1=s2=s3
        c = ((c1*length(d1))+(c2*length(d2))+(c3*length(d3)))/(length(d1)+length(d2)+length(d3));
        res_test = pdf(data_test, p1,p2,p3,m1,m2,m3,c,c,c);
        accu = 0;
        for row=1:length(label_test)
            if label_test(row,1) == res_test(row,1)
                accu = accu+1;
            end
        end
        accuracy_final(2,i) = accu*100 / length(data_test)
        %
        % Multinomial Logistic Distribution
        dt = [d1;d2;d3];
        lt = [l1;l2;l3];
        para = mnrfit(dt , lt);
        para = [para,zeros(length(para),1)];
        pihat = mnrval(para , data_test);
        [prob,res] = max(pihat,[],2);
        accu = 0;
        for row = 1:size(label_test,1)
            if res(row,1) == label_test(row,1)
                accu = accu+1;
            end
        end
        accuracy_final(3,i) = accu*100 / size(label_test,1)
        %
        
    end
    %}
end

    
    
    
    
    
    