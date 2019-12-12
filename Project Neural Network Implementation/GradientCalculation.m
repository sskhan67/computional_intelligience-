function [layers] = GradientCalculation(layers)
        

    num_layers = length(layers);

    for l = 2:num_layers
        layers(l).grad = layers(l-1).x*layers(l).del';
    end
end