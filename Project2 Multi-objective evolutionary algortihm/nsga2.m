%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA120
% Project Title: Non-dominated Sorting Genetic Algorithm II (NSGA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

% Calculated time array 
Kung_t = [];
Naive_t = [];

for s_alg = 1:2 % outer loop to select kungs, and naive implementation 
    for pop_m = 1:5 % to iterate over population array [40 80 120 160 200]
        kung_time = 0; % temp kung's time
        naive_time = 0; % temp naive time 
        for trial = 1:200 % number of trials, 200 
            
            %% Problem Definition
            
            CostFunction=@(x) MOP4(x);      % Cost Function
            
            nVar=3;             % Number of Decision Variables
            
            VarSize=[1 nVar];   % Size of Decision Variables Matrix
            
            VarMin=-5;          % Lower Bound of Variables
            VarMax= 5;          % Upper Bound of Variables
            
            % Number of Objective Functions
            nObj=numel(CostFunction(unifrnd(VarMin,VarMax,VarSize)));
            
            
            %% NSGA-II Parameters
            
            MaxIt=1;      % Maximum Number of Iterations
            
            nPop=pop_m*40;        % Population Size
            
            pCrossover=0.7;                         % Crossover Percentage
            nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)
            
            pMutation=0.4;                          % Mutation Percentage
            nMutation=round(pMutation*nPop);        % Number of Mutants
            
            mu=0.02;                    % Mutation Rate
            
            sigma=0.1*(VarMax-VarMin);  % Mutation Step Size
            
            
            %% Initialization
            
            empty_individual.Position=[];
            empty_individual.Cost=[];
            empty_individual.Rank=[];
            empty_individual.DominationSet=[];
            empty_individual.DominatedCount=[];
            empty_individual.CrowdingDistance=[];
            
            pop=repmat(empty_individual,nPop,1);
            
            for i=1:nPop
                
                pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
                
                pop(i).Cost=CostFunction(pop(i).Position);
                
            end
            
            % Non-Dominated Sorting
            [pop, F]=naive_implementation(pop);
            
            % Calculate Crowding Distance
            pop=CalcCrowdingDistance(pop,F);
            
            % Sort Population
            [pop, F]=SortPopulation(pop);
            
            
            %% NSGA-II Main Loop
            
            for it=1:MaxIt
                
                % Crossover
                popc=repmat(empty_individual,nCrossover/2,2);
                for k=1:nCrossover/2
                    
                    i1=randi([1 nPop]);
                    p1=pop(i1);
                    
                    i2=randi([1 nPop]);
                    p2=pop(i2);
                    
                    [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position);
                    
                    popc(k,1).Cost=CostFunction(popc(k,1).Position);
                    popc(k,2).Cost=CostFunction(popc(k,2).Position);
                    
                end
                popc=popc(:);
                
                % Mutation
                popm=repmat(empty_individual,nMutation,1);
                for k=1:nMutation
                    
                    i=randi([1 nPop]);
                    p=pop(i);
                    
                    popm(k).Position=Mutate(p.Position,mu,sigma);
                    
                    popm(k).Cost=CostFunction(popm(k).Position);
                    
                end
                
                % Merge
                pop=[pop
                    popc
                    popm]; %#ok
                
                
                % our implementation starts here : Kungs algorithm 
                if s_alg == 1 % loop: select algorithm 
                    tic; %Start stopwatch timer: Matlab built in function 
                    [minArray]=kung_implementation(pop); % call kung method 
                    end_k = toc;% stop time 
                
                      
                else
                % Naive implementation: Non-Dominated Sorting 
                    tic;
                    [pop, F]=naive_implementation(pop);
                    end_t = toc;% stop time 
                end %  end method selecting 
                         
                
            end           
            if s_alg == 1
                kung_time = end_k + kung_time; % sum calculated time 
            else
                naive_time = end_t + naive_time;% sum calculated time 
            end
            
        end
        
        
        if s_alg == 1
            
            kung_time = kung_time/trial;% normalized time 
            Kung_t = [Kung_t;kung_time];% add to array 

        else
            naive_time = naive_time/trial;% normalized time 
            Naive_t = [Naive_t;naive_time];% add to array

        end
        
    end

end

%% Plot results 

% population array 
pop_array = [40    80   120   160   200];
figure;
hold on;
title(" Pareto fronts implementation: Kung vs Naive  ");

set(gca,'YScale','log'); % log scale set, becasue Kung_t/Naive_t >200 

% plot 
plot(pop_array,Kung_t,'color','g','DisplayName','Kungs Method');
plot(pop_array,Naive_t,'color','b','DisplayName','Naive implementation');
xlabel('Population');
ylabel('Time [s]');
legend 
grid on
hold off;

