function applyFaceDetector(imageFileName, threshold)
    windowLength = 21;
    scaleFactor = 0.9;
    
    originalImage = imread(imageFileName);
    grayscaleImage = double(rgb2gray(originalImage));
    taggedImage = originalImage;
    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();
    [width, height] = size(originalImage);
    
    if (height >= 500)
        scale = 500/height;
    else
        scale = 1.0;
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
    [path, imageName, ext] = fileparts(imageFileName);
    newImageFileName = strcat(path,'/',imageName,'_tagged',ext);
    imwrite(taggedImage, newImageFileName);
end
