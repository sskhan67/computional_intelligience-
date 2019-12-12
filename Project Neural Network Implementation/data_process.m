function [X1,Y1] = data_process(X,Y)
% input:  X,Y
% output: 1's 


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
        y1=[y1 1];
        
    
    else 
        x1=[x1 c(i,1)];
        x2=[x2 c(i,2)];
        y1=[y1 0];
        
    end
    
    
end
N=length(x1);

X1= [x1;x2]';
Y1=y1';


end

