clc
clear all
close all
%% . Training Pocket Algorithm

% load data 
load('usps_modified.mat');
[ X,Y ] = getfeatures( data );
c=[X,Y];
num_data=size(X(:,1));
num_data=num_data(1);

% process data for getting 1,5 values
x1=[];
x2=[];
y1=[];
for i=1:num_data
    
    if c(i,3)==1 
        x1=[x1 c(i,1)];
        x2=[x2 c(i,2)];
        y1=[y1 -1];
        
    end
    if c(i,3)==5 
        x1=[x1 c(i,1)];
        x2=[x2 c(i,2)];
        y1=[y1 1];
        
    end
    
    
end
N=length(x1);

X= [ones(1,N);x1;x2]';
Y1=y1';


X1= [zeros(1,N);x1;x2]';
Y1=y1';


err=[];
iteration=[];



%% create test set N=50
N=50;

Y = zeros(N,1)';
X = zeros(N,3);
for test=1:1000
%depend on the number of data to create trainset
        for m=1:N
            k = randi([1,1000],1,1);        
            X(m,:)= X1(k,:);
            Y(m) = Y1(k);        
        end
 Y=Y';
 num_data=N;
 
 
 w = -1 +2*rand(1,3);
 w(:,1) = 0;
 
 % train PLA function 
    [wtag,error,iter]=pocket_function(X,Y,w,N);
    err=[err error ];
    iteration=[iteration iter];
    
    % error out 
    Eout=0;
   
    for t=1:N
         Y_hyp_test = sign(dot((wtag),X(t,:)));
        if Y(t) ~= Y_hyp_test
            Eout = Eout + 1;
        end 
    end
end

     plot_data(X,Y,wtag,N) 
     title('Sample dataset N=50')
     disp(" ----    Training Results N=50 ----------")
     fprintf('Average In error: %d \n',round(  (sum(err)*N)/1000 ) );
     fprintf('Average Out error: %d \n',Eout);
     fprintf('Average iteration: %d \n',round(sum(iteration)/1000));


%% create test set N=200
N=200;
err1=[];
iteration1=[];
Y = zeros(N,1)';
X = zeros(N,3);
for test=1:1000
%depend on the number of data to create trainset
        for m=1:N
            k = randi([1,1000],1,1);        
            X(m,:)= X1(k,:);
            Y(m) = Y1(k);        
        end
 Y=Y';
 num_data=N;
 
 
 w = -1 +2*rand(1,3);
 w(:,1) = 0;
 
 % train PLA function 
    [wtag,error1,iter1]=pocket_function(X,Y,w,N);
    err1=[err1 error1 ];
    iteration1=[iteration1 iter1];
    
    % error out
    Eout=0;
    for t=1:N
        if Y(t) ~= Y_hyp_test
            Eout = Eout + 1;
        end 
    end  
               
end

     plot_data(X,Y,wtag,N) 
     title('Sample dataset N=200')
     disp(" ----    Training Results N=200 ----------")
     fprintf('Average In error: %d \n',round( (sum(err1)*N)/1000) );
     fprintf('Average Out error: %d \n',Eout);
     fprintf('Average iteration: %d \n',round(sum(iteration1)/1000));
     
