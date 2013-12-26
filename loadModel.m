function [transVectors centroids V nV M] = loadModel()
  transVectors = dlmread("config/transVec.dat",","); 
  centroids = dlmread("config/centroids.dat",","); 
  V = dlmread("config/vecV.dat",",");
  nV = dlmread("config/vecNV.dat",",");
  M = dlmread("config/matM.dat",",");
endfunction
