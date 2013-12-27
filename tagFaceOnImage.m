function [newImage] = tagFaceOnImage(oldImage,xStart,yStart,windowLength)
  newImage = oldImage;
  xEnd = xStart + windowLength - 1;
  yEnd = yStart + windowLength - 1;

  for x = xStart:xEnd
    newImage(x,yStart,:) = [0 255 0];
    newImage(x,yEnd,:) = [0 255 0];
  end
  for y = yStart:yEnd
    newImage(xStart,y,:) = [0 255 0];
    newImage(xEnd,y,:) = [0 255 0];
  end
end
