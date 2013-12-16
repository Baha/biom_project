#!/usr/bin/octave -qf

if (nargin != 2)
  usage("train_face_detector <num_regions> <num_patterns>\n");
endif

arg_list = argv();
nRegions = str2num(arg_list{1});
nPatterns = str2num(arg_list{2});

#faces = dlmread("dfFaces_21x21.fmt.norm", ",");
#no_faces = dlmread("NotFaces_21x21.fmt.norm", ",");

[nFaces dimFaces] = size(faces);
[nNotFaces ans] = size(not_faces);

V  = zeros(nRegions, nPatterns);
nV = zeros(nRegions, nPatterns);
% Review M matrix majors
M  = zeros(nRegions, nPositions, nPatterns);

for i = 1:nFaces
  for j = 1:nRegions
    % Reducir dimension de la region
    for k = 1:nPositions
      % curPattern = patron que asigna kmeans
      V(j,k,curPattern)++;
    end
  end
end

for i = 1:nNotFaces
  for j = 1:nRegions
    nV(j,curPattern)++;
  end
end
