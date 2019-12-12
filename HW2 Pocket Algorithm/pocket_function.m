function [W,Ein,iter]=pocket_function(X,Y,W,num_data) 
    
    % Input: X,y -> Dataset, W=weight vector   
    % W -> pocket weight vector 
    
        iter = 0;
        w_pocket = zeros(1,3);
        Ein = 0;% erro
        iter=0;% iter
        
        
        for i=1:400
             
             % PLA : 1 update for w
             for j = 1:num_data
                 
                 Y_hyp_test = sign(dot((W),X(j,:)));
                 
                if Y(j) ~= Y_hyp_test
                    Ein = Ein + 1;
                end
             end
             
             Ein=Ein/num_data;
             
             % randmom point generator 
             ran_point = randi([1,num_data],1,1);
             
           % calculate signals , s=sign(w^T.x) and check missclassified
             % data
             
             if (Y(ran_point)*dot((W),X(ran_point,:)))<=0
                 
                 w_pocket=W+Y(ran_point)*X(ran_point,:);
                 
                 E0 = 0;% error 
                 for z = 1:num_data
                    Y_hyp_test = sign(dot((w_pocket),X(z,:)));
                    
                    if Y(z) ~= Y_hyp_test
                       E0 = E0 + 1;
                    end
                 end
                 
                 E0=E0/num_data; 
                 
                 if (E0 < Ein)

                     W=w_pocket;
                    iter = iter+1;
          
                 end
                 
             end
             
        end
        
        
        
        
    
    end