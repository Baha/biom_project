function [regionData] = getRegionFromImage(image,xRegion,yRegion,regionLength,rowLength)
  regionData = [];
  curPixel = (xRegion - 1) * regionLength + (yRegion - 1) * regionLength * rowLength + 1;
  for i = 1:regionLength
    regionRow = image(curPixel:(curPixel + regionLength - 1));
    regionData = [regionData regionRow];
    curPixel += rowLength;
  end
endfunction
