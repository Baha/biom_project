function [sortedVectors newData sortedValues] = princomp(data,nDimensions)
  normData = center(data);
  covMat = cov(normData);
  [eigVectors eigValues] = eig(covMat);
  [sortedValues order] = sort(diag(eigValues), 'descend');
  sortedVectors = eigVectors(:,order);
  newData = (sortedVectors(:,1:nDimensions)' * normData')';
endfunction
