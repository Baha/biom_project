function trainFaceDetector(nPatterns)
    % Fixed parameters (regions and reduced dimensions)
    nRegions = 16;
    nDimensions = 9;

    % Load the data
    faces = dlmread('dfFaces_21x21.norm');
    notFaces = dlmread('NotFaces_21x21.norm');
    allData = [faces; notFaces];

	% Get properties from data
    [nFaces, dimFaces] = size(faces);
    [nNotFaces, ~] = size(notFaces);
    nData = nFaces + nNotFaces;

    % Obtain subregions from every image
    regionsData = fragmentImages(allData,nData,dimFaces,nRegions);
    % Obtain principal components using PCA
    prinComp = pca(regionsData);
    transVectors = prinComp(1:nDimensions,:)';
    % Project data (Reduce dimensionality)
    reducedData = regionsData * transVectors;
    % Apply k-means algorithm
    [patterns, centroids] = kmeans(reducedData,nPatterns);
    % Compute the V and nV vectors and the M matrix
    [V, nV, M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns);
    % And store it
    createDataFiles(transVectors,centroids,V,nV,M);
end
