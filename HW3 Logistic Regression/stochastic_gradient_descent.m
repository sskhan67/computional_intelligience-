function [ result ] = stochastic_gradient_descent(training, learningRate)

[d, N] = size(training);

flag = 1;

x = training(2:d, :);
y = training(1, :);

% d-1 because the first value is the result
w = zeros(d-1,1);
iter = 1;
preGrad = 0;
while flag==1
    i = randi([1 N], 1); %get a random integer from 1 to N
    if iter > 1
        preGrad = grad;
    end
    
    ys = (y(:,i)*dot(w, x(:,i)));

    % logistic function, 1/[1+e^(s) where s is -Yn*s
    logis = 1/(1+exp(-ys)); 

    %calculate gradient for each element, Yn*Xn*logistic(-Yn*s)
    grad = -(y(:,i)*x(:,i)*logis);
    %grad = GradientSignal(w, x(:,i), y(:,i));
    
    %update weight vector
    w = w + (learningRate)*grad;
    iter = iter +1;


    % Gradient hasn't changed significantly in the last n - # of iter, stop
    if round(grad, 5) == round(preGrad, 5)
        flag = 0;
    end 

end

result = w;

end