function toyc_main()
load toySpiral
%
g = [2,4,8,16];
row=0;
col=0;
d1 = zeros(4,3);
d2 = zeros(4,3);
d3 = zeros(4,3);
d4 = zeros(4,3);

c1=cell(4,1);
c2=cell(4,1);
c3=cell(4,1);
c4=cell(4,1);

for i=1:size(g,2)
    %
    % data set 1
    accu_test=0;
    accuTest_batchGD_norm=0;
        [row,col] = size(data1.xTr);
        f1 = toy_grid(data1.xTr(:,1),g(1,i));
        f2 = toy_grid(data1.xTr(:,2),g(1,i));
        d1_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d1tr=d1_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data1.xTe);
        f_1 = toy_grid(data1.xTe(:,1),g(1,i));
        f_2 = toy_grid(data1.xTe(:,2),g(1,i));
        d1_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d1te=d1_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [d1(i,:),c1{i}] = cv(d1tr,data1.yTr-1,d1te,data1.yTe-1,10); 
        
      %
      % data set 2
      [row,col] = size(data2.xTr);
        f1 = toy_grid(data2.xTr(:,1),g(1,i));
        f2 = toy_grid(data2.xTr(:,2),g(1,i));
        d2_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d2tr=d2_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data2.xTe);
        f_1 = toy_grid(data2.xTe(:,1),g(1,i));
        f_2 = toy_grid(data2.xTe(:,2),g(1,i));
        d2_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d2te=d2_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [d2(i,:),c2{i}] = cv(d2tr,data2.yTr-1,d2te,data2.yTe-1,10);
      %
      % data set 3
      [row,col] = size(data3.xTr);
        f1 = toy_grid(data3.xTr(:,1),g(1,i));
        f2 = toy_grid(data3.xTr(:,2),g(1,i));
        d3_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d3tr=d3_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data3.xTe);
        f_1 = toy_grid(data3.xTe(:,1),g(1,i));
        f_2 = toy_grid(data3.xTe(:,2),g(1,i));
        d3_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d3te=d3_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [d3(i,:),c3{i}] = cv(d3tr,data3.yTr-1,d3te,data3.yTe-1,10);
      %
      % data set 4
      [row,col] = size(data4.xTr);
        f1 = toy_grid(data4.xTr(:,1),g(1,i));
        f2 = toy_grid(data4.xTr(:,2),g(1,i));
        d4_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d4tr=d4_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data4.xTe);
        f_1 = toy_grid(data4.xTe(:,1),g(1,i));
        f_2 = toy_grid(data4.xTe(:,2),g(1,i));
        d4_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d4te=d4_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [d4(i,:),c4{i}] = cv(d4tr,data4.yTr-1,d4te,data4.yTe-1,10);
       
end
disp('Training Validation and Testing Accuracy for data 1 with each value of grid = ')
d1
disp('Best parameters for data 1 for each value of grid = ')
c1
%}
%
% with regularization
lambda = [1,0.1,0.01,0.001];
rd1_k10 = zeros(4,3);
rd2_k10 = zeros(4,3);
rd3_k10 = zeros(4,3);
rd4_k10 = zeros(4,3);

rc1=cell(4,1);
rc2=cell(4,1);
rc3=cell(4,1);
rc4=cell(4,1);
for i=1:size(lambda,2)
    %
    % data set 1
    accu_test=0;
    accuTest_batchGD_norm=0;
        [row,col] = size(data1.xTr);
        f1 = toy_grid(data1.xTr(:,1),8);
        f2 = toy_grid(data1.xTr(:,2),8);
        d1_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d1tr=d1_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data1.xTe);
        f_1 = toy_grid(data1.xTe(:,1),8);
        f_2 = toy_grid(data1.xTe(:,2),8);
        d1_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d1te=d1_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [rd1_k10(i,:),rc1{i}] = cv_regularization(d1tr,data1.yTr-1,d1te,data1.yTe-1,10,lambda(1,i)); 
      %
      % data set 2
      [row,col] = size(data2.xTr);
        f1 = toy_grid(data2.xTr(:,1),8);
        f2 = toy_grid(data2.xTr(:,2),8);
        d2_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d2tr=d2_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data2.xTe);
        f_1 = toy_grid(data2.xTe(:,1),8);
        f_2 = toy_grid(data2.xTe(:,2),8);
        d2_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d2te=d2_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [rd2_k10(i,:),rc2{i}] = cv_regularization(d2tr,data2.yTr-1,d2te,data2.yTe-1,10,lambda(1,i));
      %
      % data set 3
      [row,col] = size(data3.xTr);
        f1 = toy_grid(data3.xTr(:,1),8);
        f2 = toy_grid(data3.xTr(:,2),8);
        d3_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d3tr=d3_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data3.xTe);
        f_1 = toy_grid(data3.xTe(:,1),8);
        f_2 = toy_grid(data3.xTe(:,2),8);
        d3_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d3te=d3_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [rd3_k10(i,:),rc3{i}] = cv_regularization(d3tr,data3.yTr-1,d3te,data3.yTe-1,10,lambda(1,i));
      %
      % data set 4
      [row,col] = size(data4.xTr);
        f1 = toy_grid(data4.xTr(:,1),8);
        f2 = toy_grid(data4.xTr(:,2),8);
        d4_tr = [f1,f2];
        %d1_tr=[ones(row,1) d1_tr];
        d4tr=d4_tr;
        %d1tr = featureNormalize(d1_tr); 
        
        
        [row,col] = size(data4.xTe);
        f_1 = toy_grid(data4.xTe(:,1),8);
        f_2 = toy_grid(data4.xTe(:,2),8);
        d4_te = [f_1,f_2];
        %d1_te=[ones(row,1) d1_te];
        d4te=d4_te;
        %d1te = featureNormalize(d1_te);
        % k=10
        [rd4_k10(i,:),rc4{i}] = cv_regularization(d4tr,data4.yTr-1,d4te,data4.yTe-1,10,lambda(1,i));    
end
disp('Training Validation and Testing Accuracy with l2 norm reg for data 1 with each value of grid = ')
rd1_k10
disp('Best parameters for data 1 for each value of grid = ')
rc1
%}

%
% Part b
i11 = toy_grid(data1.xTr(:,1),8);
i12 = toy_grid(data1.xTr(:,2),8);
g164 = grid_64(i11,i12);
it11 = toy_grid(data1.xTe(:,1),8);
it12 = toy_grid(data1.xTe(:,2),8);
gt164 = grid_64(it11,it12);


i21 = toy_grid(data2.xTr(:,1),8);
i22 = toy_grid(data2.xTr(:,2),8);
g264 = grid_64(i21,i22);
it21 = toy_grid(data2.xTe(:,1),8);
it22 = toy_grid(data2.xTe(:,2),8);
gt264 = grid_64(it21,it22);

i31 = toy_grid(data3.xTr(:,1),8);
i32 = toy_grid(data3.xTr(:,2),8);
g364 = grid_64(i31,i32);
it31 = toy_grid(data3.xTe(:,1),8);
it32 = toy_grid(data3.xTe(:,2),8);
gt364 = grid_64(it31,it32);

i41 = toy_grid(data4.xTr(:,1),8);
i42 = toy_grid(data4.xTr(:,2),8);
g464 = grid_64(i41,i42);
it41 = toy_grid(data4.xTe(:,1),8);
it42 = toy_grid(data4.xTe(:,2),8);
gt464 = grid_64(it41,it42);

lambda = [1,0.1,0.01,0.001];
nd1 = zeros(4,3);
nd2 = zeros(4,3);
nd3 = zeros(4,3);
nd4 = zeros(4,3);

nc1=cell(4,1);
nc2=cell(4,1);
nc3=cell(4,1);
nc4=cell(4,1);

for lam=1:length(lambda)
    % data 1
    [nd1(lam,:) , nc1{lam}] = icv_regularization(g164,data1.yTr-1,gt164,data1.yTe-1,lambda(1,lam))
    %
    % data 1
    [nd2(lam,:) , nc2{lam}] = icv_regularization(g264,data2.yTr-1,gt264,data2.yTe-1,lambda(1,lam))
    %
    % data 1
    [nd3(lam,:) , nc3{lam}] = icv_regularization(g364,data3.yTr-1,gt364,data3.yTe-1,lambda(1,lam))
    %
    % data 1
    [nd4(lam,:) , nc4{lam}] = icv_regularization(g464,data4.yTr-1,gt464,data4.yTe-1,lambda(1,lam))
    %
end
disp('Training Validation and Testing Accuracy with neighbor regularization for data 1 with each value of grid = ')
nd1
disp('Best parameters for data 1 for each value of grid = ')
nc1
%}
end









