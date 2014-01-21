function [V, nV, M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns)
  % Declare V, nV vectors and M matrix
  V  = zeros(nPatterns);
  nV = zeros(nPatterns);
  M  = zeros(nRegions, nPatterns);

  % Increment counters from V and M using regions from faces
  curRegion = 1;
  for i = 1:nFaces
    for j = 1:nRegions
      V(patterns(curRegion)) = V(patterns(curRegion)) + 1;
      M(j,patterns(curRegion)) = M(j,patterns(curRegion))+ 1;
      curRegion = curRegion + 1;
    end
  end

  % Increment counters from nV using regions from notfaces
  for i = 1:nNotFaces
    for j = 1:nRegions
      nV(patterns(curRegion)) = nV(patterns(curRegion)) + 1;
      curRegion = curRegion + 1;
    end
  end

  % Normalize vectors and columns of matrix
  V = V / sum(V);
  nV = nV / sum(nV);
  for i = 1:nPatterns
    sumCol = sum(M(:,i));
    if (sumCol <= 0.0)
      M(:,i) = 0;
    else
      M(:,i) = M(:,i) / sumCol;
    end
  end
end
