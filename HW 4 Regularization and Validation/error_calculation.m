function [Ein,Eout] = error_calculation(xtest,xtrain,ytest,ytrain,w)
% Input: test dataset:xtest & ytest  , train dataset:xtrain & ytrain, and weight function: w
% Output: In samle error: Ein, Out sample error: Eout 


% Out sample error calculation 
Eout=0;
[test_size,~]=size(xtest);
xtest=[ones(test_size,1),xtest];




for i = 1:test_size
        
        Eout = Eout+(( ytest(i) - ( sign( dot( w,xtest(i,:)))))^2) /2;
end 
        Eout=Eout/test_size;

        
% In sample error 

Ein=0;
[train_size,~]=size(xtrain);
xtrain=[ones(train_size,1),xtrain];

    for i = 1:train_size
        
        
        Ein = Ein +  (( ytrain(i) - ( sign( dot( w,xtrain(i,:)))))^2) /2;
    end 
        Ein = Ein/train_size;


        
 

end

