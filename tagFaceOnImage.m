function [newImage] = tagFaceOnImage(oldImage,scaleFactor,xStart,xEnd,yStart,yEnd)
  newImage = oldImage;
  xStart = floor(xStart / scaleFactor);
  xEnd = floor(xEnd / scaleFactor);
  yStart = floor(yStart / scaleFactor);
  yEnd = floor(yEnd / scaleFactor);
  
  for x = xStart:xEnd
    newImage(x,yStart,:) = [0 255 0];
    newImage(x,yEnd,:) = [0 255 0];
  end
  for y = yStart:yEnd
    newImage(xStart,y,:) = [0 255 0];
    newImage(xEnd,y,:) = [0 255 0];
  end
end
