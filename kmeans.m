function [classes, centroids]= kmeans(data, nClusters)

nDims = length(data(1,:));
nSamples = length(data(:,1));
cent_diff = 1.0;

% Initialization of centroids
data_min = min(data);
data_max = max(data);
data_diff = data_max - data_min ;
centroids = rand(nClusters, nDims);

% Random centroids are scaled to the data
for i = 1:nClusters
  centroids(i,:) = centroids(i,:) .* data_diff;
  centroids(i,:) = centroids(i,:) + data_min;
end

% Iterate until there are no changes
while cent_diff > 0.0
  classes = [];

  % Each datapoint is assigned to the class
  % with the closest centroid
  for d = 1:nSamples
    min_dist = (data(d,:) - centroids(1,:));
    min_dist = min_dist * min_dist';
    curClass = 1;

    for c = 2:nClusters
      dist = (data(d,:) - centroids(c,:));
      dist = dist * dist';
      if( min_dist >= dist)
        curClass = c;
        min_dist = dist;
      end
    end

    classes = [classes; curClass];
  end

  % Save old centroids for computing its difference
  oldCentroids = centroids;

  % Recompute new positions of the centroids
  centroids = zeros(nClusters, nDims);
  nPointsInCluster = zeros(nClusters, 1);

  for d = 1:length(classes)
    centroids(classes(d),:) += data(d,:);
    nPointsInCluster(classes(d),1)++;
  end

  for c = 1: nClusters
    if(nPointsInCluster(c,1) != 0)
      centroids(c,:) = centroids(c,:) / nPointsInCluster(c,1);
    else
      % Set centroid to a new random position
      centroids(c,:) = (rand(1,nDims) .* data_diff) + data_min;
    end
  end

  cent_diff = sum(sum((centroids - oldCentroids).^2))
end
