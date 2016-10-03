function [theta,cost_history,counter,accu_plot] = batchGD(x,y,theta,alpha,isRaw,spam_train)
%function [theta,cost_history,counter,costTest_history,accu_plot] = batchGD(x,y,theta,alpha,x1,y1,isRaw)

cost_history(1) = 0;
counter = 1;
past_cost = 1000000;
%pastTest_cost=10000000;
flag = 1;
accu_plot=0;
while flag
    htheta = sigmoid(x*theta);
    new_theta = zeros(size(theta,1),1);
    for feature=1:size(theta,1)
        new_theta(feature) = theta(feature) - alpha * sum((htheta - y) .* x(:,feature));
    end
    theta = new_theta;
    
    %calculating accuracy at iteration = counter
    accu_plot(counter) = accu_q4(spam_train,y,theta);
    %
    
    current_cost = computeCost(x,y,theta);
%        currentTest_cost = computeCost(x1,y1,theta);
%((past_cost-current_cost)<=0.01)) can be plugged in if below
    if (isnan(current_cost) || isinf(current_cost)|| (past_cost<current_cost) || (past_cost-current_cost)<0.0001)   && isRaw==0
        flag = 0;
    elseif isRaw && (counter>=1000) 
        flag=0;
    else
        cost_history(counter) = current_cost;
 %       costTest_history(counter) = currentTest_cost;
        counter = counter+1;
        past_cost = current_cost;
  %      pastTest_cost = currentTest_cost;
    end
end
counter;
size(accu_plot);
end