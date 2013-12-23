function createDataFiles(transVectors,centroids,V,nV,M)
  rmdir("config","s");
  mkdir("config");
  dlmwrite("config/transVec.dat",transVectors,","); 
  dlmwrite("config/centroids.dat",centroids,","); 
  dlmwrite("config/vecV.dat",V,",");
  dlmwrite("config/vecNV.dat",nV,",");
  dlmwrite("config/matM.dat",M,",");
endfunction
