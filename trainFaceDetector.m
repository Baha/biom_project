#!/usr/bin/octave -qf

if (nargin != 1)
  usage("trainFaceDetector.m <num_patterns>\n");
endif

arg_list = argv();
%nRegions = str2num(arg_list{1});
nRegions = 16;
nDimensions = 9;
nPatterns = str2num(arg_list{1});

faces = dlmread("dfFaces_21x21.fmt.norm", ",");
notFaces = dlmread("NotFaces_21x21.fmt.norm", ",");
allData = [faces; notFaces];

[nFaces dimFaces] = size(faces);
[nNotFaces ans] = size(notFaces);
nData = nFaces + nNotFaces;

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

[ans reducedData ans] = princomp(regionsData,nDimensions);
[patterns ans] = kmeans(reducedData,nPatterns);
[V nV M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns);
