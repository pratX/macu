function [J, grad] = costFunction(theta, X, y)
    m = length(y); % number of training examples
    J = (1/(2*m)) * sum(((X * theta) - y).^2);
    grad = X' * ((X * theta) - y);
end
