function  [output] = front_index(pop,sorted_index)
% recursive function call 
% input: population, sorted_index
%output: index 

    [~,p_size] = size(sorted_index);% size 
    half = floor(p_size/2); % take half pop size 
    output = []; % array to store sorted index 
    
    if p_size == 0 % check empty array 
        return;
    elseif p_size == 1 % array size not empty 
        output = sorted_index;
    else
        [t_index] = front_index(pop,sorted_index(:,1:half));
        [bindex] = front_index(pop,sorted_index(:,(half+1):p_size));
        [~,k] = size(t_index);
        [~,l] = size(bindex);
        
        for i = 1:l
            isDominated = false;% domination check flag 
            for j = 1:k
                obj1 = pop(bindex(i)).objectTwo;
                obj2 = pop(t_index(j)).objectTwo;
                if obj1 > obj2
                    isDominated = true;
                    break;
                end
            end
            if isDominated == false
                output = [output;bindex(i)];
            end
            
        end
        
        output = [output; t_index];% append to array 
    end

end
