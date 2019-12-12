function [forward_p_output,layers] = fp(layers)

    % logistic (sigmoid) activation function
    theta = @(x) 1./(1+exp(-1*x));   %logistic function  
    num_layers = length(layers);  
    
    for l = 2:num_layers
        layers(l).s = layers(l).w'*layers(l-1).x;       %calculate signal
        layers(l).x = vertcat(1,theta(layers(l).s));    %calculate output
    end
    
        forward_p_output = layers(3).x(2);
    
  
end