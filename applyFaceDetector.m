function applyFaceDetector(imageFileName, threshold)
    windowLength = 21;

    originalImage = imread(imageFileName);
    grayscaleImage = double(rgb2gray(originalImage));
    taggedImage = originalImage;

    maxOffset = size(grayscaleImage) - windowLength;
    imageMean = mean2(grayscaleImage);
    imageStd = std2(grayscaleImage);
    normImage = (grayscaleImage - imageMean) / imageStd;

    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();

    for j = 1:4:maxOffset(2)
      for i = 1:4:maxOffset(1)
        imageWindow = normImage(i:(i+windowLength-1),j:(j+windowLength-1));
        score = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M);
        if (score > threshold)
          taggedImage = tagFaceOnImage(taggedImage,i,j,windowLength);
        end
      end
    end
    imwrite(taggedImage, 'tagged.jpg', 'jpg');
end
