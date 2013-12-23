#!/usr/bin/octave -qf

if (nargin != 1)
  usage("trainFaceDetector.m <num_patterns>\n");
endif

arg_list = argv();
nRegions = 16;
nDimensions = 9;
nPatterns = str2num(arg_list{1});

faces = dlmread("dfFaces_21x21.fmt.norm", ",");
notFaces = dlmread("NotFaces_21x21.fmt.norm", ",");
allData = [faces; notFaces];

[nFaces dimFaces] = size(faces);
[nNotFaces ans] = size(notFaces);
nData = nFaces + nNotFaces;

regionsData = fragmentImages(allData,nData,dimFaces,nRegions);
[transVectors reducedData ans] = princomp(regionsData,nDimensions);
[patterns centroids] = kmeans(reducedData,nPatterns);
[V nV M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns);
createDataFiles(transVectors,centroids,V,nV,M);
