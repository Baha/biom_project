#!/usr/bin/octave -qf

if (nargin != 1)
  usage("trainFaceDetector.m <num_patterns>\n");
endif

arg_list = argv();
%nRegions = str2num(arg_list{1});
nRegions = 16;
nPositions = 9;
nPatterns = str2num(arg_list{1});

faces = dlmread("dfFaces_21x21.fmt.norm", ",");
notFaces = dlmread("NotFaces_21x21.fmt.norm", ",");
allData = [faces; notFaces];

[nFaces dimFaces] = size(faces);
[nNotFaces ans] = size(notFaces);
nData = nFaces + nNotFaces;

V  = zeros(nRegions, nPatterns);
nV = zeros(nRegions, nPatterns);
M  = zeros(nRegions, nPositions, nPatterns);

nxRegions = nyRegions = sqrt(nRegions);
nPixelsPerRow = nPixelsPerRow
nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);
regionsData = [];
for i = 1:nData
  for x = 1:nxRegions
    for y = 1:nyRegions
    curRegion = getRegionFromImage(allData(i),x,y,nPixelsPerRegion,nPixelsPerRow);
    regionsData = [regionsData; curRegion];
  end
end

for i = 1:nFaces
  for j = 1:nRegions
    % Reducir dimension de la region
    for k = 1:nPositions
      % curPattern = patron que asigna kmeans
      V(j,curPattern)++;
      M(j,k,curPattern)++;
    end
  end
end

for i = 1:nNotFaces
  for j = 1:nRegions
    nV(j,curPattern)++;
  end
end

for i = 1:nRegions
  V(i,:) = V(i,:) / sum(nV(i,:);
  nV(i,:) = nV(i,:) / sum(nV(i,:);
  for j = 1:nPatterns
    M(i,j,:) = M(i,j,:) / sum(M(i,j,:));
  end
end
