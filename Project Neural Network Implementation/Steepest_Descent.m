function [Erros, Ein, Eout,lr] = Steepest_Descent(xtrain, xtest, ytrain, ytest, layers)


    
    [M,~] = size(xtrain);
    [N,~] = size(xtest);
    
   
    t = 1;
    prevError = -1;
    errorSimilarity = 0;
    Erros=[];
    
    Ein = 0;
    Eout = 0;
    num_layers = length(layers);
    
    while errorSimilarity < 20 && t < 50
       
        %perform forward propagation
        layers(1).x = xtrain(t,:)';
        y = ytrain(t);
        [fpoutput, layers] = fp(layers);
        
        %calculate the error 
        temp2 = ((1/2)*((fpoutput - y)^2));
        Erros=[Erros temp2]; 
        
        %perform back-propagation 
    	[layers] = backPropagation(layers,y);
        
        
        %line search 
        [lr] = line_search(layers, y);
        
        %update weight 
        for l = 2:num_layers
            layers(l).w = layers(l).w-(lr*layers(l).grad);
        end
        
     
        Ein = Erros(t);
        t = t+1;
        
    
        %calculate the error
        
        error = 0;
        for j = 1:N
             
            %perform Forward Propagation
              layers(1).x = xtest(j,:)';
              y = ytest(j);
              [fpoutput,layers] = fp(layers);
              
              %calculate the error in average
              temp = ((1/(2*N))*((fpoutput - y)^2));
              error = error + temp;
        end
    
            Eout= error;
    
        % stopping criteria 
        
        if abs(error - prevError) < 0.01
            errorSimilarity = errorSimilarity + 1;
        else
            errorSimilarity = 0;
        end
            prevError = error;  
    end
    
end






