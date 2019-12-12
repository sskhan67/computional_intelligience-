clc
clear all
close all

% Steps: 1. load values from dataset, 2. set 1 as 1 and rest numbers are -1
% 3. shuffle the dataset 4. perform non-linear transformation 5. prepare dataset for 10 fold validation
%6. calculate in sample and out sample error 7. find min error to get best learning rate


%%
% 1. load data 
load('usps_modified.mat');
[ X,Y ] = getfeatures( data );
%%
% 2. set 1 as 1 and rest as -1 
[X,Y] = data_process(X,Y);
%%
%3. Shuffle dataset 
[X,Y] = shuffle_data(X,Y);
%%

[N,~]=size(X); % dataset size 
%%
% 4. Non linear transformation 

Z=zeros(N, 9); % create Z matrix fill with zeros
    
    for i=1:N
       Z(i,:)=[X(i,1);X(i,2);(X(i,1))^2;X(i,1)*X(i,2);(X(i,2))^2;(X(i,1))^3;((X(i,1))^2)*X(i,2);
           X(i,1)*(X(i,2))^2; (X(i,2))^3;];
    end
 %%
    

lambda_set=[0.001,0.01,0.1,0.25,0.5,0.75,1];% learning rate

Ein_t=[]; % in sample error 
Eout_t=[];% out sample error 

fold=10; % 10-fold cross validation
w_array=[];
[~,N_lambda]=size(lambda_set); 

for j=1:N_lambda   %  iterate over lambda values 
    Ein=0;   
    Eout=0;

    % 10 fold data set preparation , model train and test, error
    % calculation 
    for i =1:fold
        low_limit=(i-1)*500+1;
        upper_lmit=low_limit+499;
    
        xtest=Z(low_limit:upper_lmit,:);
        ytest=Y(low_limit:upper_lmit,:);
    
    
        if upper_lmit<=500
            xtrain=Z(upper_lmit+1:5000,:); % row 501 to 5000
            ytrain=Y(upper_lmit+1:5000,:);
        
        elseif  upper_lmit> 500 &&  upper_lmit<=4500
    
    
    
            xtrain=[Z(1:low_limit-1,:) ;Z(upper_lmit+1:5000,:)];
            ytrain=[Y(1:low_limit-1,:) ;Y(upper_lmit+1:5000,:)];
        
        elseif upper_lmit>4500
            
            xtrain=Z(1:low_limit-1,:);
            ytrain=Y(1:low_limit-1,:);
            
            
            
            
        
        end
    
    
    [w] = linreg(xtrain,ytrain,lambda_set(j));
    w_array=[w_array; w'];
    [Ein_tmp,Eout_tmp] = error_calculation(xtest,xtrain,ytest,ytrain,w);
    Ein=Ein_tmp+Ein;
    
    
    Eout=Eout_tmp+Eout;
    
    
    
    end
    % form array of error for different labmda 
    Ein_t=[Ein_t Ein/10];
    Eout_t=[Eout_t Eout/10];
    
end
%% avg weight vector 

[N_array,step]=size(w_array);
wtag=zeros(7,10);
wtag(1,:)=sum(w_array(1:10,:))/10;
wtag(2,:)=sum(w_array(11:20,:))/10;
wtag(3,:)=sum(w_array(21:30,:))/10;
wtag(4,:)=sum(w_array(31:40,:))/10;
wtag(5,:)=sum(w_array(41:50,:))/10;
wtag(6,:)=sum(w_array(51:60,:))/10;
wtag(7,:)=sum(w_array(61:70,:))/10;




% 7. Choice best lambda

disp("Labmda parameter set: ");
disp(lambda_set)

disp("In sample error for different lambda: " );
disp(Ein_t)

disp("Out sample error for different lambda: " );
disp(Eout_t)

[min_error,index]=min(Eout_t); % get min error value with index 

disp("Best Lambada for this model: ");
disp(lambda_set(index))


%% plot 
lambda_best=lambda_set(index);
[num_data,~]=size(X);
Z = [ones(num_data,1),Z];
plot_data(X,Y,wtag(index,:),num_data,Z)




 