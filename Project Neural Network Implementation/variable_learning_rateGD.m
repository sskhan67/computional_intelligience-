 function [Errors, Ein,Eout,lr] = variable_learning_rateGD(xtrain, xtest, ytrain, ytest, layers)

    
    [M,~] = size(xtrain);
    [N,~] = size(xtest);
    
    a = 1.11; % alpha range 1.05<= a <= 1.1
    b = 0.8; % beta range .5 <= b <= .8
    
    t = 1;
    prevError = -1;
    errorSimilarity = 0;
    lr = 0.01; % learning rate 
    %Erros = zeros(25,1);
    Errors=[];
    num_layers = length(layers);
    
    while errorSimilarity < 10 && t < 50
       
        %do forward propagation
        layers(1).x = xtrain(t,:)';
        y = ytrain(t);
        [fpout, layers] = fp(layers);
        
        %calculate the error 
        temp2 = ((1/2)*((fpout - y)^2));
        EinPrev = temp2;
        
        %do back-propagation 
    	[layers] = backPropagation(layers,y);
        
        %copy the old weight
        for l = 2:num_layers
            layers(l).wPrev = layers(l).w;
        end
        
        %update weight vector
        for l = 2:num_layers
            layers(l).w = layers(l).w-(lr*layers(l).grad);
        end
        
        %calculate the error 
        [fpout, layers] = fp(layers);
        temp2 = ((1/2)*((fpout - y)^2));
        EinNew = temp2;
        
        
         if EinNew < EinPrev
             
               lr = a*lr; % increasing learning rate 
              % Erros(t) = EinNew; % update error 
              Errors=[Errors EinNew];
         else 
               lr = b*lr; % decreasing learning rate 
               
               %update weight 
                for l = 2:num_layers
                    layers(l).w = layers(l).wPrev;
                end
               %Erros(t) = EinPrev;
               Errors=[Errors EinNew];
         end
         Ein = Errors(t);
         t = t+1;
        
    
        %calculate the error
        
        error = 0;
        for j = 1:N
             %perform  forward propagation
              layers(1).x = xtest(j,:)';
              y = ytest(j);
              [fpout,layers] = fp(layers);
              
              %calculate the error in average
              temp = ((1/(2*N))*((fpout - y)^2));
              error = error + temp;
        end
        
        Eout = error;
    
   
    
        % stopping criteria 
        if abs(error - prevError) < 0.1
            errorSimilarity = errorSimilarity + 1;
        else
            errorSimilarity = 0;
        end
            prevError = error;  
    end    

 end