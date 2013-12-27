#!/usr/bin/octave -qf

if (nargin != 2)
  usage("applyFaceDetector.m <image_file> <threshold>\n");
endif

arg_list = argv();
imageFileName = arg_list{1};
threshold = str2double(arg_list{2});
windowLength = 21;

originalImage = imread(imageFileName);
[image map] = rgb2ind(originalImage);
grayscaleImage = ind2gray(image,map);
taggedImage = originalImage;

maxOffset = size(grayscaleImage) - windowLength;
normImage = center(grayscaleImage);
stdCol = std(grayscaleImage);

for j = 1:maxOffset(2)
  normImage(:,j) = normImage(:,j) / stdCol(j);
end

[nRegions nDimensions nPatterns transVectors centroids V nV M] = loadModel();

for j = 1:2:maxOffset(2)
  for i = 1:2:maxOffset(1)
    imageWindow = grayscaleImage(i:(i+windowLength-1),j:(j+windowLength-1));
    score = computeScore(imageWindow,nRegions,nDimensions,nPatterns,windowLength,transVectors,centroids,V,nV,M)
    if (score > threshold)
      taggedImage = tagFaceOnImage(taggedImage,i,j);
    endif
  end
end
%imwrite(grayscaleImage, "gris.jpg", "jpg");
