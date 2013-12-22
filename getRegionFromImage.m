function [regionData] = getRegionFromImage(image,xRegion,yRegion,regionLength,rowLength)
  regionData = [];
  curPixel = xRegion * regionLength + yRegion * regionLength * rowLength;
  for i = 1:regionLength
    regionRow = image(curPixel:(curPixel + regionLength));
    regionData = [regionData regionRow];
    curPixel += rowLength
  end
endfunction
