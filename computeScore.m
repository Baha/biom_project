function [score] = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M)
  % Obtain properties of the image
  nxRegions = sqrt(nRegions);
  nyRegions = nxRegions;
  nPixelsPerRow = windowLength;
  nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);

  % Score is computed as a productory, initial value must be 1
  score = 1.0;  
  regionIndex = 1;

  % For each region
  for y = 1:nyRegions
    for x = 1:nxRegions
      % Obtain region_ij
      curRegion = getRegionFromImage(imageWindow',x,y,nPixelsPerRegion,nPixelsPerRow);
	  % Project data from it to reduce dimensionality
      transRegion = curRegion * transVectors;

	  % Obtain closest pattern
      min_dist = transRegion - centroids(1,:);
      min_dist = min_dist * min_dist';
      curPattern = 1;

      for i = 2:nPatterns
        dist = transRegion - centroids(i,:);
        dist = dist * dist';
        if(min_dist >= dist)
          curPattern = i;
          min_dist = dist;
        end
      end

	  % Some checks are performed to avoid zero-divions
      if (nV(curPattern) <= 0.0)
          if ((M(regionIndex, curPattern) * V(curPattern)) <= 0.0)
              score = 0.0;
          else
              score = 999.9;
          end
      else
	  	 % New score is recomputed
         score = score * (M(regionIndex,curPattern) * V(curPattern)) / ((1.0/nRegions) * nV(curPattern));
      end
      regionIndex = regionIndex + 1;
    end
  end
end
