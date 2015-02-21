function out = mapFeature(X, degree = 7)
    %Assuming there is only one feature i.e. only one column in X
    out = X(:,1);
    if degree >= 2,
        for i = 2:degree,
            out = [out X(:,1).^i];
        end
    end
end
