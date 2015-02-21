metricList = readdir('/home/pratikku/test/macu/hypotheses');
for i = 3:length(metricList),
    metricList{i} = strsplit(metricList{i},".mat"){1};
end
filename = "/home/pratikku/test/macu/regression/anomaly_op";
fid = fopen (filename, "w");
for i = 3:length(metricList),
    load(strcat('/home/pratikku/test/macu/hypotheses/',metricList{i},'.mat'));
    %theta, mu_t, sigma_t, avg_dev
    data = load(strcat('/home/pratikku/test/macu/live_metrics/',metricList{i}));
    X = data(:,1);
    X = (X - mu_t) ./ sigma_t; 
    X = mapFeature(X, (size(theta,1) - 1));
    X = [ones(size(X,1),1) X];
    prediction = X * theta;
    avg_dev_live = mean(abs(prediction - data(:,2)));
    if avg_dev_live > avg_dev,
        fprintf(fid,'%s\n', metricList{i});
    endif
end
fclose(fid);
