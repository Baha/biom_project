function [regionsData] = fragmentImages(data,nData,dimData,nRegions)
  nxRegions = nyRegions = sqrt(nRegions);
  nPixelsPerRow = sqrt(dimData);
  nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);

  regionsData = [];
  for i = 1:nData
    for y = 1:nyRegions
      for x = 1:nxRegions
        curRegion = getRegionFromImage(data(i,:),x,y,nPixelsPerRegion,nPixelsPerRow);
        regionsData = [regionsData; curRegion];
      end
    end
  end
endfunction
