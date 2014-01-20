function [normImage, pixelShift, maxX, maxY] = scaleImage(image,scaleFactor)
    if (scaleFactor <= 1.0)
        image = imresize(image, scaleFactor);
    end
        [maxX, maxY] = size(image);
        imageMean = mean2(image);
        imageStd = std2(image);
        normImage = (image - imageMean) / imageStd;
        
        if (maxY >= 512)
            pixelShift = 16;
            return;
        end
        if (maxY >= 256)
            pixelShift = 8;
            return;
        end
        
        if (maxY >= 128)
            pixelShift = 4;
            return;
        end
        pixelShift = 2;
end

