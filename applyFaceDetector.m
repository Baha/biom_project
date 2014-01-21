function applyFaceDetector(imageFileName, threshold)
	% Fixed parameters
    windowLength = 21;
    scaleFactor = 0.9;
    scale = 1.0;

	% Load image and convert to grayscale
    originalImage = imread(imageFileName);
    grayscaleImage = double(rgb2gray(originalImage));
    [height, ~, ~] = size(originalImage);
    taggedImage = originalImage;

	% Load model
    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();
    
	% Adjust initial scale
    if (height > 128)
        scale = 128/height;
    end
    
	% Multiscale loop, each iteration we reduce current scale to 90 %
    for s = 1:10
		% Scale (and normalize) image according to current scale
        [normImage, pixelShift, maxX, maxY] = scaleImage(grayscaleImage, scale);
		% Sliding window for computing the scores
        for j = 1:pixelShift:maxY-windowLength
          for i = 1:pixelShift:maxX-windowLength
            imageWindow = normImage(i:(i+windowLength-1),j:(j+windowLength-1));
			% Compute score from current region
            score = computeScore(imageWindow,nRegions,nPatterns,windowLength,transVectors,centroids,V,nV,M);
			% If this score is higher than the given threshold, tag face on image
            if (score > threshold)
              taggedImage = tagFaceOnImage(taggedImage,scale,i,i+windowLength-1,j,j+windowLength-1);
            end
          end
        end
        scale = scale * scaleFactor;
    end
	% Append "_tagged" to image file name and store it
    [path, imageName, ext] = fileparts(imageFileName);
    if (strcmp(path,''))
        newImageFileName = strcat(imageName,'_tagged',ext);
    else
        newImageFileName = strcat(path,'/',imageName,'_tagged',ext);
    end
    imwrite(taggedImage, newImageFileName);
end
