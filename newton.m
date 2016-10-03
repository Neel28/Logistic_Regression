function [theta,cost_history,counter,accu_plot] = newton(x,y,theta,alpha,isRaw)

cost_history(1) = 0;
counter = 1;
past_cost = 1000000;
flag = 1;
m = length(y);
while flag
    htheta = sigmoid(x*theta);
    grad1 = (1/m).*x' * (htheta-y);
    grad2 = (1/m).*x' * diag(htheta) * diag(1-htheta) * x;
    t=size(grad2,1);
    H = inv( grad2 + eye(t)*1e-3 );
    theta = theta - H*grad1;
     
    %calculating accuracy at iteration = counter
    accu_plot(counter) = accu_q4(x,y,theta);
    %
    
    current_cost = computeCost(x,y,theta);
    if (isnan(current_cost) || (past_cost<current_cost) || (past_cost-current_cost<=0.001)) && isRaw==0
        flag = 0;
    elseif isRaw && (counter>=1000) 
        flag = 0;
    else
        cost_history(counter) = current_cost;
        counter = counter+1;
        past_cost = current_cost;
    end
end

end