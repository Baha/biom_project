function [score] = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M)
  nxRegions = sqrt(nRegions);
  nyRegions = nxRegions;
  nPixelsPerRow = windowLength;
  nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);

  regionIndex = 1;
  score = 1.0;  

  for y = 1:nyRegions
    for x = 1:nxRegions
      curRegion = getRegionFromImage(imageWindow',x,y,nPixelsPerRegion,nPixelsPerRow);
      transRegion = curRegion * transVectors;
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
      if (nV(curPattern) <= 0.0)
          if ((M(regionIndex, curPattern) * V(curPattern)) <= 0.0)
              score = 0.0;
          else
              score = 999.9;
          end
      else
         score = score * (M(regionIndex,curPattern) * V(curPattern)) / ((1.0/nRegions) * nV(curPattern));
      end
      regionIndex = regionIndex + 1;
    end
  end
end
