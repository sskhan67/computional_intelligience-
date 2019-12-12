clc
clear all
close all
%% . Training Pocket Algorithm

% load data 
load('usps_modified.mat');
[ X,Y ] = getfeatures( data );
[N,~]=size(X);

X=[Y ones(N,1) X];

for i=1:N
    
    if Y(i,1) ~=1 
        X(i,1)=-1;
        

        
    end
end

training=[X(1:400,:) ;X(501:900,:);X(1001:1400,:);X(1501:1900,:);X(2001:2400,:);X(2501:2900,:);X(3001:3400,:);X(3501:3900,:);X(4001:4400,:);X(4501:4900,:)];
testing=[X(401:500,:) ;X(901:1000,:); X(1401:1500,:);X(1901:2000,:);X(2401:2500,:);X(2901:3000,:);X(3401:3500,:);X(3901:4000,:);X(4401:4500,:);X(4901:5000,:)];

lr = 0.1; % learning rates of 0.1, 1, 10, 50.
Ein=[];
Eout=[];

 for i=1:10

    [w] = batch_gradient_descent(training',testing', lr);
   
 end
[in, out,E1,E2] = error_calculation(training', testing', w);

fprintf('Average gradient descent In error: %d \n',in);
fprintf('Average gradient descent Out error: %d \n',out);
fprintf('Classification error In error: %d \n',E1);
fprintf('classification error Out error: %d \n',E2);
plot_data(training(:,2:4),training(:,1)',w,4000) 

plot_data(testing(:,2:4),testing(:,1)',w,1000) 

