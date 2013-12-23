#!/usr/bin/octave -qf

if (nargin != 2)
  usage("applyFaceDetector.m <image_file> <threshold>\n");
endif

arg_list = argv();
imageFileName = arg_list{1};
threshold = str2double(arg_list{2});

originalImage = imread(imageFileName);
[image map] = rgb2ind(originalImage);
grayscaleImage = uint8(ind2gray(image,map));

imwrite(grayscaleImage, "gris.jpg", "jpg");
