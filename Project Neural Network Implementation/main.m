clc
clear all
close all

%Neural netwrok implementation 

% Steps: 1. load values from dataset, 2. set 1 as 1 and rest numbers are 0
% 3. shuffle the dataset 4. perform non-linear transformation 5. prepare dataset for 10 fold validation
%6. calculate in sample and out sample error 7. find min error to get best learning rate


%%
% 1. load data 
load('usps_modified.mat');
[ X,Y ] = getfeatures( data );
%%
% 2. set 1 as 1 and rest as 0
[X,Y] = data_process(X,Y);
%%
%3. Shuffle dataset 
[X,Y] = shuffle_data(X,Y);
%%

[N,~]=size(X); % dataset size 

    
lambda_set=[0.001,0.01,0.1,0.25,0.5,0.75,1];% learning rate

Ein_t=[]; % in sample error 
Eout_t=[];% out sample error 

fold=10; % 10-fold cross validation
w_array=[];
[~,N_lambda]=size(lambda_set); 


[xtrain,xtest,ytrain,ytest] = fold_ten(X,Y);


%setup data 
num_layers = 3; %number of layers including the input layer
layers(1:num_layers,1) = struct;

% weight vector matrices
layers(2).w = rand(2,5);
layers(3).w = rand(6,1);
Ein=[];
Eout=[];

fprintf('Select weight update method: \n 1. Variable Learning Rate \n 2. Stochastic Update Method \n 3. Steepest Descent (Gradient Descent with Line Search)  \n 4. Batch Update Method \n ')

 
n = input('Enter a number between 1 to 4: ');

switch n
    case 1
        for i=1:10
            [Error_array,Erroin, Errout,~] =variable_learning_rateGD(xtrain,xtest,ytrain,ytest,layers);
            Ein=[Ein Erroin];
            Eout=[Eout Errout];
        end
        
   case 2
        for i=1:10
            [Error_array,Erroin,Errout,~] = stochastic_GD(xtrain, xtest, ytrain, ytest, layers);
            Ein=[Ein Erroin];
            Eout=[Eout Errout];
        end
            
   case 3
        for i=1:10
            [Error_array,Erroin,Errout,~] = Steepest_Descent(xtrain, xtest, ytrain, ytest, layers);            Ein=[Ein Erroin];
            Ein=[Ein Erroin];
            Eout=[Eout Errout];
        end
  case 4
        for i=1:10
            [Error_array,Erroin, Errout,~] = Batch_Update(xtrain, xtest, ytrain, ytest, layers);            Ein=[Ein Erroin];
            Ein=[Ein Erroin];
            Eout=[Eout Errout];
        end
  otherwise
        disp('Wrong selection ')
end


disp("Avergae in Sample error, Ein: " + sum(Ein)/length(Ein));
disp("Avergae in Out error, Eout: " + sum(Eout)/length(Eout));


Error_array=[Error_array 0 0 0];
figure();
plot(Error_array);
title("Plots of error over iteration/epoch")
xlabel('Epoch')
ylabel("Error")
grid on


figure();
scale = 2/length(Error_array);
x=-1:scale:1;
y=-1:scale:1;
[X1,Y1]= meshgrid(x,y);



Z = zeros(size(X1));
for i = 1:length(Error_array)
    for j = 1:length(Error_array)
        Z(i,j) = RunForwardProp(layers, [X1(i,j); Y1(i,j)]);
    end
end
[c1,~] = max(Z(:));
[c2,~] = min(Z(:));

Z=((Z-c2)/(c1-c2));

surf(x,y,Z);
xlabel('x1');
ylabel('x2');
zlabel('y');

colorbar;
view(2);




figure();

hold on;
axis([-1 1 -1 1]);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

pd=zeros(5000,2);
pd_0=zeros(5000,2);

for i=1:5000
    if Y(i,1)==1
        pd(i,1)=X(i,1);
        pd(i,2)=X(i,2);
    else 
        pd_0(i,1)=X(i,1);
        pd_0(i,2)=X(i,2);
        
    end
end
        
scatter(pd(:,1), pd(:,2),5,'g','filled');
    
scatter(pd_0(:,1), pd_0(:,2),5,'r','filled');
xlabel('x1');
ylabel('x2');
title('Data points on 2D plane')
hold off;
   
