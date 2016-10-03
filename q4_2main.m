function q4_2main()
load data_train
load label_train
load data_test
load x1_tr
load x2_tr
load x3_tr
load label_test

[res_test,accuracy_final] = trainEvalModels;

p = [1,5,10,25,50,100];

plot(p,accuracy_final(1,:),'r:')
hold on
plot(p,accuracy_final(2,:),'b:')
hold on
plot(p,accuracy_final(3,:),'g:')
xlabel('Split in %')
ylabel('Accuracy')
legend('Model 1','Model 2','Model 3')

end
