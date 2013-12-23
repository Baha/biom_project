function [V nV M] = countAndNormalize(nFaces,nNotFaces,nRegions,nPatterns,patterns)
  V  = zeros(nPatterns);
  nV = zeros(nPatterns);
  M  = zeros(nRegions, nPatterns);

  curRegion = 1;
  for i = 1:nFaces
    for j = 1:nRegions
      V(patterns(curRegion))++;
      M(j,patterns(curRegion))++;
      curRegion++;
    end
  end

  for i = 1:nNotFaces
    for j = 1:nRegions
      nV(patterns(curRegion))++;
      curRegion++;
    end
  end

  V = V / sum(V);
  nV = nV / sum(nV);
  for i = 1:nPatterns
    M(:,i) = M(:,i) / sum(M(:,i));
  end
endfunction