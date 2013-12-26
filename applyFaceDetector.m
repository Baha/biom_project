#!/usr/bin/octave -qf

if (nargin != 2)
  usage("applyFaceDetector.m <image_file> <threshold>\n");
endif

arg_list = argv();
imageFileName = arg_list{1};
threshold = str2double(arg_list{2});

originalImage = imread(imageFileName);
[image map] = rgb2ind(originalImage);
grayscaleImage = ind2gray(image,map);

maxOffset = size(grayscaleImage) - 21;
normImage = center(grayscaleImage);
stdCol = std(grayscaleImage);

for j = 1:maxOffset(2)
  normImage(:,j) = normImage(:,j) / stdCol(j);
end

[transVectors centroids V nV M] = loadModel();

for j = 1:2:maxOffset(2)
  for i = 1:2:maxOffset(1)
    imageWindow = grayscaleImage(i:(i+21),j:(j+21));
    score = computeScore();
    if (score > threshold)
      taggedImage = tagFaceOnImage(taggedImage,i,j);
    endif
  end
end
%imwrite(grayscaleImage, "gris.jpg", "jpg");
