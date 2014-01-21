function [newImage] = tagFaceOnImage(oldImage,scaleFactor,xStart,xEnd,yStart,yEnd)
  % Copy image
  newImage = oldImage;

  % Indices depend on the scaling factor
  xStart = floor(xStart / scaleFactor);
  xEnd = floor(xEnd / scaleFactor);
  yStart = floor(yStart / scaleFactor);
  yEnd = floor(yEnd / scaleFactor);
  
  % For the start of each coordinate to its end,
  % change color from pixel to green
  for x = xStart:xEnd
    newImage(x,yStart,:) = [0 255 0];
    newImage(x,yEnd,:) = [0 255 0];
  end
  for y = yStart:yEnd
    newImage(xStart,y,:) = [0 255 0];
    newImage(xEnd,y,:) = [0 255 0];
  end
end
