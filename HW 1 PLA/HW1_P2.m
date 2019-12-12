%working  input samples
clc
clear all
close all
%% . Training PLA

iter_array=[];
mdata_array=[];
Repeat =1;
learning_rate=1;
    % data points 
for k=1:Repeat
    num_data=100;

    % Data set creation 
    X=0.2*randn(num_data,2);
    Y=ones(num_data,1);
    Y(X(:,2)<X(:,1))=-1;
    X=X';
    Y=Y';
    % inital weight vector
    w= -1 +2*rand(2,1);
  
    % train PLA function 
    [wtag,m_point,iter]=perceptron(X,Y,w,learning_rate);

    iter_array=[iter_array iter];

    if k==Repeat
        plot_data(X,Y,wtag,num_data)

        disp(" ----    Training Results  ----------")
        %fprintf('Number of misclassified data points:%d \n',m_point);
        fprintf('Number of iterations for convergence: %d \n',round((iter_array)/1));
        disp("final weight matrix after training is:")
        disp(wtag)

    end
        %%                      testing data

    % Trained weight vector
    w1=wtag;

    % Test data set 
    num_data=100*num_data;
    X1=0.1*randn(num_data,2);

    Y1=ones(num_data,1);
    Y1(X1(:,2)<X1(:,1))=-1;
    X1=X1';
    Y1=Y1';

    % calculate & compare mismatched points 
    for i=1:num_data
        Y_t(i)=sign(w1'*X1(:,i)); 
    
    end
    error=eq(Y_t,Y1);

    % No. of mismatched points 
    mismatch_points=num_data-sum(error);
    mdata_array=[mdata_array mismatch_points];
    if k==Repeat
    % plot mismatched data 
    %plot_data(X1,Y1,w1,num_data)

    % Print results 
    disp(" ----    Test Results  ----------")
    fprintf('Number of misclassified data points:%d \n',round((mdata_array)));
    end


end   
 


function [w,m_point,iter] = perceptron(X,Y,w_init,learning_rate)

w = w_init;
m_point = 0;
error=1;
iter=0;
while (error>0 )
   % if iter<=1000
    error=0;
  for ii = 1 : size(X,2)         %cycle through training set
    if sign(w'*X(:,ii)) ~= Y(ii) %wrong decision?
      w = w + learning_rate.* X(:,ii) .* (Y(ii)-w'*X(:,ii));   %then add (or subtract) this point to w
      m_point = m_point + 1;
      error=error+1;
      iter=iter+1;
    end
    
%     if iter==1000
%         error=1;
%     end
    
  %end
    end
  
 
end
end

function t=plot_data(X1,Y1,w1,num_data)
    figure;
    hold on;
    for i = 1:num_data % plot data points
        if Y1(i) == 1
            scatter(X1(1,i),X1(2,i),'r','+','LineWidth',2);
        else
            scatter(X1(1,i),X1(2,i),'g','o','LineWidth',2);
        end
    end
    axis([-1 1 -1 1])
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';

    % generate data for drawing hypothesis line
    w1=[0, w1' ];
    x=X1(1,:)';
    xl=linspace( min(x), max(x),10 );
    yl1 = -(w1(2)*xl+w1(1))/w1(3);
    plot(xl,yl1,'Color','blue','LineWidth',1);
end