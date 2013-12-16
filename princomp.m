function [sortedVectors, sortedValues] = princomp(data)
  % Not needed, but just in case
  normData = center(data);
  covMat = cov(normData);
  [eigVectors, eigValues] = eig(covMat);
  [sortedValues, order] = sort(diag(D), 'descend');
  sortedVectors = eigVectors(:, i);
endfunction
