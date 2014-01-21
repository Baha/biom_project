function [normImage, pixelShift, maxX, maxY] = scaleImage(image,scaleFactor)
		% Resize image
        image = imresize(image, scaleFactor);

		% Normalize image
        [maxX, maxY] = size(image);
        imageMean = mean2(image);
        imageStd = std2(image);
        normImage = (image - imageMean) / imageStd;
        
		% Return an adequate pixelShift value (for sliding window)
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

