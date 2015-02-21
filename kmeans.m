metricList = readdir('/home/pratikku/test/macu/kmeans/metrics');
%metricList{3:length(metricList)}
timestamp = [0;0];
value = [0;0];
metric_index = [0;0];
prediction = [0;0];

for i = 3:length(metricList),
    %metricList{i} = strsplit(metricList{i},".mat"){1};
    data = load(strcat('/home/pratikku/test/macu/kmeans/metrics/',metricList{i}));
    timestamp = [timestamp ; data(:,1)];
    value = [value; data(:,2)];
    metric_index = [metric_index; (i * ones(size(data,1),1))];  
    load(strcat('/home/pratikku/test/macu/hypotheses/',metricList{i},'.mat'));
    %theta, mu_t, sigma_t
    X = (data(:,1) - mu_t) ./ sigma_t ;
    X = mapFeature(X, size(theta,1)-1);
    X = [ones(size(X,1),1) X];
    prediction = [prediction; X * theta];
end
%input for k-means ready 
%[ metric_index timestamp value prediction ]

inp = [timestamp(3:size(timestamp,1),1) (value(3:size(value,1),1) - prediction(3:size(prediction,1),1)).^2];
[inp_norm, mu, sigma] = featureNormalize(inp);
K = 5;
max_iters = 15;
%initialCentroids = kMeansInitCentroids(inp, K);
initialCentroids = kMeansInitCentroids(inp_norm, K);
%[centroids, idx] = runkMeans(inp, initialCentroids, max_iters, true);
[centroids, idx] = runkMeans(inp_norm, initialCentroids, max_iters, true);
%idx -> cluster_id
%[timestamp value metric_index prediction](3:) <=> idx

