function [layers] = backPropagation(layers,y)
    

    num_layers = length(layers);
    thetap = @(x) x.*(1-x);     %derivative of logistic function (1/1-e^-s)

    x = layers(num_layers).x(2:length(layers(num_layers).x));   %remove bias
    layers(num_layers).del = 2*thetap(x).*(x - y);              %initialize last layer

    for l = num_layers-1:-1:2
        x = layers(l).x(2:length(layers(l).x));             %remove the bias 
        w = layers(l+1).w(2:length(layers(l+1).w));         %remove bias weight
        layers(l).del = thetap(x).*(w * layers(l+1).del);   %get next delta
    end
    
    %Gradient Calculation 
    [layers] = GradientCalculation(layers);
    

end