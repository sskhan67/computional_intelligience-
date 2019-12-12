function [n1, n2, n3] = linesearch_initialization(layers, y)

epsilon = 0.1;
n1 = 0;
n2 = epsilon;
n3 = 0;

%copy layers
networkforE1 = layers;
networkforE2 = layers;
networkforE3 = layers;

%weight update
%[networkforE1] = WeightUpdate(n1, networkforE1);
[networkforE2] = WeightUpdate(n2, networkforE2);

%calulation of error

[E1] = errorMeasure(networkforE1, y);
[E2] = errorMeasure(networkforE2, y);




    if E2 > E1
       n3 = 2*n2;
    else
       n1 = n2;
       n2 = 0;
       n3 = -1 * epsilon;
    end
    
    networkforE3 = WeightUpdate(n3, networkforE3);
    [E3] = errorMeasure(networkforE3, y);
    
    
while E3 < E2 
      n1 = n2;
      n2 = n3;
      n3 = 2*n3;
      networkforE2 = WeightUpdate(n2, networkforE2);
      [E2] = errorMeasure(networkforE2, y);

      networkforE3 = WeightUpdate(n3, networkforE3);
      [E3] = errorMeasure(networkforE3, y);

end
    
    

end