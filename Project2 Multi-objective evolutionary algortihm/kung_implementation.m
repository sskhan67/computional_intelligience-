function [minArray]=kung_implementation(pop)

% I/P: population 
% array 
    % size 
    [popsize,~] = size(pop);
    
    %unrolling data 
    for i = 1: popsize
        pop(i).objectOne = pop(i).Cost(1,1);
        pop(i).objectTwo = pop(i).Cost(2,1);
    end
    %sorting: first obejct approch and descending   
    [~,index] = sort([pop.objectOne],'descend');
    
    %comparsion and dominance calculation 
    [minArray] = front_index(pop,index); 
end
