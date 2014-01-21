function [regionsData] = fragmentImages(data,nData,dimData,nRegions)
  % Obtain properties of the image
  nxRegions = sqrt(nRegions);
  nyRegions = nxRegions;
  nPixelsPerRow = sqrt(dimData);
  nPixelsPerRegion = floor(nPixelsPerRow / nxRegions);

  regionsData = [];
  % For each image and each region
  for i = 1:nData
    for y = 1:nyRegions
      for x = 1:nxRegions
	  	% Obtain the region_ij from image and append it to the list
        curRegion = getRegionFromImage(data(i,:),x,y,nPixelsPerRegion,nPixelsPerRow);
        regionsData = [regionsData; curRegion];
      end
    end
  end
end
