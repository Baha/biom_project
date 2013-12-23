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
nPixelsPerRow = sqrt(dimFaces);
nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);

%[nxRegions nPixelsPerRow nPixelsPerRegion]

regionsData = [];
for i = 1:nData
  for y = 1:nyRegions
    for x = 1:nxRegions
      curRegion = getRegionFromImage(allData(i,:),x,y,nPixelsPerRegion,nPixelsPerRow);
      regionsData = [regionsData; curRegion];
    end
  end
end

[ans reducedData ans] = princomp(regionsData,nPositions);
[assignedData ans] = kmeans(reducedData,nPatterns);

%for i = 1:nFaces
%  for j = 1:nRegions
%    % Reduce dimensions from region
%    for k = 1:nPositions
%      % curPattern = pattern assigned by kmeans
%      V(j,curPattern)++;
%      M(j,k,curPattern)++;
%    end
%  end
%end
%
%for i = 1:nNotFaces
%  for j = 1:nRegions
%    nV(j,curPattern)++;
%  end
%end
%
%for i = 1:nRegions
%  V(i,:) = V(i,:) / sum(nV(i,:));
%  nV(i,:) = nV(i,:) / sum(nV(i,:));
%  for j = 1:nPatterns
%    M(i,j,:) = M(i,j,:) / sum(M(i,j,:));
%  end
%end
