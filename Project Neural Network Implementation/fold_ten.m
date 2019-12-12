function [xtrain,xtest,ytrain,ytest] = fold_ten(X,Y)
fold=10;

for i =1:fold
        low_limit=(i-1)*500+1;
        upper_lmit=low_limit+499;
    
        xtest=X(low_limit:upper_lmit,:);
        ytest=Y(low_limit:upper_lmit,:);
    
    
        if upper_lmit<=500
            xtrain=X(upper_lmit+1:5000,:); % row 501 to 5000
            ytrain=Y(upper_lmit+1:5000,:);
        
        elseif  upper_lmit> 500 &&  upper_lmit<=4500
    
    
    
            xtrain=[X(1:low_limit-1,:) ;X(upper_lmit+1:5000,:)];
            ytrain=[Y(1:low_limit-1,:) ;Y(upper_lmit+1:5000,:)];
        
        elseif upper_lmit>4500
            
            xtrain=X(1:low_limit-1,:);
            ytrain=Y(1:low_limit-1,:);
            
            
            
            
        
        end
    

%training=[xtrain,ytrain];
% test=[xtest,ytest];
end

