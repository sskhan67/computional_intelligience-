function [ result ] = batch_gradient_descent(training, testing, learningRate)


[d, N] = size(training);
[~, M] = size(testing);



x = training(2:d, :);
y = training(1, :);

w = rand(d-1,1);
grad = zeros(d-1, 1);

prevError = -1;

iter = 1;
errorSimilarity = 0;
threshold = 10;

while errorSimilarity < threshold
    
    
    for i = 1:N
        grad = grad + GradientSignal(w, x(:,i), y(:,i)); 
    end
    
    %calculate average direction vector, -1/N*sum of gradients
    v = grad/N; 
    
    %update weight vector
    w = w + (learningRate*v); 
    
    % Calculate Error
    errors = 0;
    for i = 1:M
        s = dot(w, testing(2:d,i));
        target = testing(1,i);
        errors = errors + ((s - target)^2);
    end
    error = errors/(2*M);
    
    % Determine if algorithm should stop
    if abs(error - prevError) < 10
        errorSimilarity = errorSimilarity + 1;
    else
        errorSimilarity = 0;
    end
    
    iter = iter + 1;
    prevError = error;
end


result = w;

end
