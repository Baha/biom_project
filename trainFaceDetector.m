function trainFaceDetector(nPatterns)
    nRegions = 16;
    nDimensions = 9;

    faces = dlmread('dfFaces_21x21.norm');
    notFaces = dlmread('NotFaces_21x21.norm');
    allData = [faces; notFaces];

    [nFaces, dimFaces] = size(faces);
    [nNotFaces, ~] = size(notFaces);
    nData = nFaces + nNotFaces;

    regionsData = fragmentImages(allData,nData,dimFaces,nRegions);
    prinComp = pca(regionsData);
    transVectors = prinComp(1:nDimensions,:)';
    reducedData = regionsData * transVectors;
    [patterns, centroids] = kmeans(reducedData,nPatterns);
    [V, nV, M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns);
    createDataFiles(transVectors,centroids,V,nV,M);
end
