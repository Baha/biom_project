function [normImage, pixelShift, maxX, maxY] = scaleImage(image,scaleFactor)
    if (scaleFactor <= 1.0)
        image = imresize(image, scaleFactor);
    end
        [maxX, maxY] = size(image);
        imageMean = mean2(image);
        imageStd = std2(image);
        normImage = (image - imageMean) / imageStd;
        if (maxY > 1024)
            pixelShift = 32;
        else if (maxY > 512)
            pixelShift = 16;
            else if (maxY > 256)
                    pixelShift = 8;
                else if (maxY > 128)
                        pixelShift = 4;
                    else
                        pixelShift = 2;
                    end
                end
            end
        end
end

