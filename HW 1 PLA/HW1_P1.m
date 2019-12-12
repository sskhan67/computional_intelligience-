
clc
clear all
close all
%% . Training PLA

iter_array=[];
mdata_array=[];
Repeat =1000;
    
for k=1:Repeat
    % data points 
    num_data=10;

    ub = 1;    %upper bound
    lb = -1;   %lower bound
    d = 2;     %dimension of space
    b = lb + (ub-lb).*rand(1);      %line offset
    temp_w = -1 + 2.*rand(d,1);     %generate weight vectors
    w0 = -b*temp_w(d);              %calculate offset weight
    w_targ = [w0; temp_w]'; 
    X=[ones(1,num_data)',lb+rand(num_data,2)*(ub-lb) ];
    Y=ones(num_data,1);

    for i = 1:num_data
        
        Y_in = sign ( dot(w_targ,X(i,:)) );
        if Y_in==+1
            Y(i,1)=1;
     
        else
            Y(i,1)=-1;
        end
 
    end
    % % inital weight vector
    w= -1 +2*rand(3,1);
  
    % train PLA function 
    [wtag,m_point,iter]=perceptron(X,Y,w,num_data);

    iter_array=[iter_array iter];

    if k==Repeat  %plot the last one  
        plot_data(X,Y,wtag,num_data)

        disp(" ----    Training Results  ----------")
        %fprintf('Number of misclassified data points:%d \n',m_point);
        fprintf('Average number of iterations for conergence (1000 times repetation:)%d \n',round(sum(iter_array)/Repeat));
        disp("final weight matrix after training is:")
        disp(wtag)

    end
        %%                      testing data

    % Trained weight vector
    w1=wtag;

    % Test data set 
    num_data=10*num_data;
    X1=[ones(1,num_data)',lb+rand(num_data,2)*(ub-lb) ];
    Y1=ones(num_data,1);
    temp_w = -1 + 2.*rand(d,1);     %generate weight vectors
    w0 = -b*temp_w(d);              %calculate offset weight
    w0 = [w0; temp_w]';              %calculate offset weight

    for i = 1:num_data
        %dot(w_targ,X(i,:))
        Y_in = sign ( dot(w0,X1(i,:)) );
        if Y_in==+1
            Y1(i,1)=1;
     
        else
            Y1(i,1)=-1;
        end
 
    end

    % calculate & compare mismatched points 
    Y_t=zeros(100,1);
    for i=1:num_data
        Y_t(i)=sign ( dot(w1,X1(i,:)) ); 
    
    end
    error=eq(Y_t,Y1);

    % No. of mismatched points 
    mismatch_points=num_data-sum(error);
    mdata_array=[mdata_array mismatch_points];
    if k==Repeat % print last one 
    % plot mismatched data 
    plot_data(X1,Y1,w1,num_data)

    % Print results 
    disp(" ----    Test Results  ----------")
    fprintf('Average number of misclassified data points for 1000 repetation :%d \n',round(sum(mdata_array)/Repeat));
    end


end   
 


function [w,m_point,iter] = perceptron(x,y,w,num_data)
y_hyp = zeros(num_data,1);
error = 1;
iter=0;
m_point = 0;
    while  1 
        error = 0;
        for i = 1:num_data
            y_hyp(i) = sign(dot(w,x(i,:)));
            
            if y_hyp(i)~=y(i)
                w = w + y(i)*x(i,:)';
             
                m_point = m_point + 1;
                error = error + 1;
                         
            end

        end
        if error==0
            break
        end
        iter=iter+1;

           
    end
end

function t=plot_data(X,Y,w,num_data)

    figure;
    hold on;

    for i = 1:num_data % plot data points
        if Y(i) == 1
            scatter(X(i,2),X(i,3),'r','+','LineWidth',2);
        else
            scatter(X(i,2),X(i,3),'g','o','LineWidth',2);
        end
    end
    axis([-2 2 -2 2])
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';

    %plot new hypothesis line
    xl = min(X(:,2)):0.1:max(X(:,2));

    yl = -(w(2)*xl+w(1))/w(3);
    plot(xl,yl,'Color','blue','LineWidth',1);
end