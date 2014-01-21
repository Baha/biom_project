function [regionData] = getRegionFromImage(image,xRegion,yRegion,regionLength,rowLength)
  regionData = [];
  % Initial pixel from region is computed
  curPixel = (xRegion - 1) * regionLength + (yRegion - 1) * regionLength * rowLength + 1;
  for i = 1:regionLength
  	% Add row of region to list
    regionRow = image(curPixel:(curPixel + regionLength - 1));
    regionData = [regionData regionRow];
	% Next pixel is equial to width of image
    curPixel = curPixel + rowLength;
  end
end
