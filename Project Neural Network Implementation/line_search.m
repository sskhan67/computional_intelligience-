function [lr] = line_search(layers, y)

[n1, n2, n3]=linesearch_initialization(layers, y);

tolerance = 0.1;
iter = 1;
perterb = 0.1;

while abs(n3 - n1) > tolerance && iter < 20
       
    nHat = 0.5*(n1 + n3);
        
        %copy network 
        networkforEnHat = layers;
        networkforE2 = layers;
        %weight update
        [networkforEnHat] = WeightUpdate(nHat, networkforEnHat);
        [networkforE2] = WeightUpdate(n2, networkforE2);
        
        if nHat < n2
           %calculate error of EnHat and E2
           [E2] = errorMeasure(networkforE2, y);
           [EnHat] = errorMeasure(networkforEnHat, y);

                
            if EnHat < E2
                n2 = nHat;
                n3 = n2;
            elseif EnHat > E2
                n1 = nHat;
            end
            
        elseif nHat > n2
            [E2] = errorMeasure(networkforE2, y);
            [EnHat] = errorMeasure(networkforEnHat, y);
            
            if EnHat < E2
               n1 = n2;
               n2 = nHat;
            elseif EnHat > E2
               n3 = nHat;
            end
               
        elseif nHat == n2
          nHat = nHat + perterb;  
            
        end
        
        iter = iter + 1;

end

    lr = nHat;


end