function applyFaceDetector(imageFileName, threshold)
    windowLength = 21;
    pixelShift = [4];
    scale = 1.0;
    
    originalImage = imread(imageFileName);
    grayscaleImage = double(rgb2gray(originalImage));
    taggedImage = originalImage;

    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();

    for s = 1:1
        [normImage, maxX, maxY] = scaleImage(grayscaleImage, scale);
        for j = 1:pixelShift(s):maxY-windowLength
          for i = 1:pixelShift(s):maxX-windowLength
            imageWindow = normImage(i:(i+windowLength-1),j:(j+windowLength-1));
            score = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M);
            if (score > threshold)
              taggedImage = tagFaceOnImage(taggedImage,scale,i,i+windowLength-1,j,j+windowLength-1);
              score
            end
          end
        end
        imwrite(taggedImage, 'tagged.jpg', 'jpg');
        scale = scale * 0.9;
    end
end
