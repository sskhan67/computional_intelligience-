function [ inError, outError,E1,E2 ] = error_calculation( training, testing, w)
%MEASUREERROR Summary of this function goes here
%   Detailed explanation goes here
[d, N] = size(training);
[~, M] = size(testing);
errors = 0;
E1=0;
E2=0;
for i = 1:N
    s = dot(w, training(2:d,i));
    errors = errors + (training(1,i) - s)^2;
    
    if sign(dot(w, training(2:d,i)))~=training(1,i)
        E1=E1+1;
        
        
    end
end
inError = errors / (2*N);
E1=E1/(1);
errors = 0;
for i = 1:M
    s = dot(w, testing(2:d,i));
    errors = errors + (testing(1,i) - s)^2;
    if sign(dot(w, training(2:d,i)))~=testing(1,i)
        E2=E2+1;
        
        
    end 
end
outError = errors / (2*M);
E2=E2/(1);

end
