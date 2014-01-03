function [normImage, maxX, maxY] = scaleImage(image,scaleFactor)
if (scaleFactor <= 1.0)
    image = imresize(image, scaleFactor);
end
    [maxX, maxY] = size(image);
    imageMean = mean2(image);
    imageStd = std2(image);
    normImage = (image - imageMean) / imageStd;
end

