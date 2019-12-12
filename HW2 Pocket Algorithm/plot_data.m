     
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
    plot(xl,yl,'Color','blue','LineWidth',2);
end
             