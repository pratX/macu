
clear ; close all; clc
fileList = readdir('/home/pratikku/test/macu/metrics');
for i = 3:numel(fileList),
    fileList{i}
    data = load(strcat('/home/pratikku/test/macu/metrics/',fileList{i}));
    %Read data
    X = data(:,1);
    y = data(:,2);

    m = size(X,1);
    degree = 7;

    %Feature Normalize
    [X_norm, mu_t, sigma_t] = featureNormalize(X);
    X_norm = mapFeature(X_norm, degree);
    X_norm = [ones(m,1) X_norm];
    %pause;
    
    %Cost Minimization
    lambda = 10;
    initial_theta = zeros(size(X_norm, 2), 1);
    %options = optimset('GradObj', 'on', 'MaxIter', 20000);
    %[theta, cost, info] = ...
    %        fminunc(@(t)(costFunction(t, X_norm, y)), initial_theta, options)
    alpha = 0.003;
    iters = 5000;
    [theta, J_history] = gradientDescent(X_norm, y, initial_theta, lambda, alpha, iters);

    y_predict = X_norm * theta;

    %figure;

    %subplot(2,1,1);
    %plot(X(:,1), y_predict, 'bo');

    %subplot(2,1,2);
    %plot(X(:,1), y, 'rx');
    
    %save theta, mu_t, sigma_t in a file
    output_file = strcat('/home/pratikku/test/macu/hypotheses/',fileList{i},'.mat')
    save(output_file, "theta", "mu_t", "sigma_t");
    
end
