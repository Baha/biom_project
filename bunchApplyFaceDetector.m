function bunchApplyFaceDetector(imageFolder)
    % Fixed global parameters
    windowLength = 21;
    thresholds = [1.0, 10.0, 100.0, 1000.0, 10000.0];
    
    % Load model
    [nRegions, nPatterns, transVectors, centroids, V, nV, M] = loadModel();
    
    % Obtain list of files from folder
    filesList = dir(imageFolder);
    
    for t = 1:numel(thresholds)
       % Create new folder
       if (~exist(strcat(imageFolder,num2str(t)),'dir'))
           mkdir(strcat(imageFolder,num2str(t)));
       end
       for im = 1:numel(filesList)
           % If file is not a directory
           if (~isdir(filesList(im).name))
                % Fixed local parameters
                scaleFactor = 0.9;
                scale = 1.0;
                threshold = thresholds(t);
                
                % Load image and convert to grayscale
                originalImage = imread(strcat(imageFolder,'/',filesList(im).name));
                grayscaleImage = double(rgb2gray(originalImage));
                [height, ~, ~] = size(originalImage);
                taggedImage = originalImage;
                
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
                % Append "_tagged" to image file name and store it in
                % current folder
                [path, imageName, ext] = fileparts(strcat(imageFolder,num2str(t),'/',filesList(im).name));
                newImageFileName = strcat(path,'/',imageName,'_tagged',ext);
                imwrite(taggedImage, newImageFileName);
            end
        end
    end
end

