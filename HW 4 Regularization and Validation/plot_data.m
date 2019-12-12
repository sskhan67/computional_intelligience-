     
function t=plot_data(X,Y,W,N,Z)

    figure();
    hold on;
    xlabel('x_1'); ylabel('x_2');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';

     for i = 1:N
            
           Y_hypothsis = sign( dot( W,Z(i,:)));

            if Y(i) == Y_hypothsis && Y(i) == 1
                scatter(X(i,1),X(i,2),'b','o','LineWidth',1);
            elseif Y(i) == Y_hypothsis && Y(i) == -1
              scatter(X(i,1),X(i,2),'g','+','LineWidth',1);
            else 
                scatter(X(i,1),X(i,2),'r','o','LineWidth',1);
            end
            
            
     end
      
end
             