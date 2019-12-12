function [Errors,Ein,Eout,lr]=Batch_Update(xtrain, xtest, ytrain, ytest, layers)


[M,~] = size(xtest);
[N,~] = size(xtrain);

iter=1;
previousEout = -1;
errorSimilarity = 0;
threshold = 10 ;
Ein = 0.4; 
num_layers = length(layers);
Errors = [];

%error is similar in last 60 times
while errorSimilarity < threshold && iter < 50 && Ein >= 0.2
    Eout = 0;
    Ein = 0;
    for i = 1:N
        
        %do Forward Propagation
        layers(1).x = xtrain(i,:)';
        y = ytrain(i);
        [fpoutput,layers] = fp(layers);
        %calculate the error in average
        temp2 = ((1/(2*N))*((fpoutput - y)^2));
        Ein = Ein + temp2;
          
        %do back-propagation 
        [layers] = backPropagation(layers,y);
        
        %calculate the gradient in average
        for l = 2:num_layers  
            
            if i == 1
                layers(l).gradinavrage = (1/N)*layers(l).grad;   
            else
                layers(l).gradinavrage = layers(l).gradinavrage + (1/N)*layers(l).grad;    
            end
        end
        
        %Errors =[ Errors Ein];
    end
    
    
    
   if iter == 1
        %Validation to find the best parameter
        [lr] = picking_best_lr(layers,xtrain,ytrain);
   end
   
   
   [layers] = WeightUpdate(lr,layers);
      
       %calculation of Eout
       for j = 1:M
           
            %do Forward Propagation
            layers(1).x = xtest(j,:)';
            y = ytest(j);
            [fpoutput,layers] = fp(layers);
            %calculate the error in average
            temp = ((1/(2*M))*((fpoutput - y)^2));
            Eout = Eout + temp;
                
       end
          Errors =[ Errors Eout];
    %if error and previous error similar.
    if abs(Eout - previousEout)<10
        errorSimilarity = errorSimilarity + 1;
    else
        errorSimilarity = 0;
    end
    
    iter = iter +1;
    previousEout = Eout;
end

end