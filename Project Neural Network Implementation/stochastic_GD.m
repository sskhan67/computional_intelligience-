function [e, Ein, Eout, lr] = stochastic_GD(xtrain, xtest, ytrain, ytest, layers)

    % Input dataset, layers
    % Output error array, learning rate 
    iter=1;
    previousEout = -1;
    Ein = 0.3;
    errorSimilarity = 0;
    
    e=[]; % error array 
    
while errorSimilarity < 20 && iter < 50 && Ein >= 0.2
    %calculate the gradient
    i = randi([1 4000],1);
    
    %do Forward Propagation
    layers(1).x = xtrain(i,:)';
    y = ytrain(i);
    
    [fpoutput,layers] = fp(layers);
    
    Ein = 0;
    %calculate the error 
    temp2 = ((1/2)*((fpoutput - y)^2));
    Ein = Ein + temp2;
    
    e=[e Ein]; % error array 
    
    % perform back-propagation 
    [layers] = backPropagation(layers,y);
    
    % best learning rate 
    [lr] = picking_best_lr(layers,xtrain,ytrain);

    %update weight v
    [layers] = WeightUpdate(lr,layers);
    
    %calculate the error
    error = 0;
    
    [M,~] = size(xtest);
    for j = 1:M
        %do Forward Propagation
            layers(1).x = xtest(j,:)';
            y = ytest(j);
            [fpoutput,layers] = fp(layers);
            
            %calculate the error in average
            temp = ((1/(2*M))*((fpoutput - y)^2));
            error = error + temp;
    end
    
    Eout = error;
 
    
       
    %stopping condition 
    
    if abs(Eout - previousEout) <  0.0001
        errorSimilarity = errorSimilarity + 1;
    else
        errorSimilarity = 0;
    end
    
    previousEout = Eout;
    
    iter = iter + 1;
    
    
  
    
end


end
