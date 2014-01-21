function bunchApplyFaceDetector(imageFolder)
    windowLength = 21;
    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();
    thresholds = [1.0, 10.0, 100.0, 1000.0, 10000.0];
    
    filesList = dir(imageFolder);
    
    for t = 1:numel(thresholds)
       if (~exist(strcat(imageFolder,num2str(t)),'dir'))
           mkdir(strcat(imageFolder,num2str(t)));
       end
       for im = 1:numel(filesList)
           if (~isdir(filesList(im).name))
                scaleFactor = 0.9;
                scale = 1.0;
                threshold = thresholds(t);
                originalImage = imread(strcat(imageFolder,'/',filesList(im).name));
                grayscaleImage = double(rgb2gray(originalImage));
                [height, ~, ~] = size(originalImage);
                taggedImage = originalImage;
                
                if (height > 128)
                    scale = 128/height;
                end

                for s = 1:10
                    [normImage, pixelShift, maxX, maxY] = scaleImage(grayscaleImage, scale);
                    for j = 1:pixelShift:maxY-windowLength
                      for i = 1:pixelShift:maxX-windowLength
                        imageWindow = normImage(i:(i+windowLength-1),j:(j+windowLength-1));
                        score = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M);
                        if (score > threshold)
                          taggedImage = tagFaceOnImage(taggedImage,scale,i,i+windowLength-1,j,j+windowLength-1);
                        end
                      end
                    end
                    scale = scale * scaleFactor;
                end
                [path, imageName, ext] = fileparts(strcat(imageFolder,num2str(t),'/',filesList(im).name));
                newImageFileName = strcat(path,'/',imageName,'_tagged',ext);
                imwrite(taggedImage, newImageFileName);
            end
        end
    end
end

