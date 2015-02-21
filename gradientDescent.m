function [theta, J_history] = gradientDescent(X, y, theta, lambda, alpha, num_iters)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
%num_features = size(X,2);
for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCostMulti) and gradient here.
    %
    %S = zeros(num_features,1);
    %for j = 1:num_features,
    %     S(j) = sum(((X * theta) - y) .* X(:,j));
    %end;
    grad = X' * ((X * theta) - y);
    grad_reg = (lambda/m) * theta;
    grad_reg(1) = 0;
    grad = grad + grad_reg;
    theta = theta - (alpha/m) * grad;
        
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = costFunction(theta, X, y); 
    J_history(iter) =  J_history(iter) + ((theta' * theta)*lambda/(2*m)) - (lambda/(2*m) * (theta(1).^2));
    if (iter >= 2) && (J_history(iter) > J_history(iter - 1)),
        break;
    end
    
end

end
