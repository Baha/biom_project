function createDataFiles(transVectors,centroids,V,nV,M)
  if (exist('config','dir'))
      rmdir('config','s');
  end
    mkdir('config');
  dlmwrite('config/transVec.dat',transVectors,','); 
  dlmwrite('config/centroids.dat',centroids,','); 
  dlmwrite('config/vecV.dat',V,',');
  dlmwrite('config/vecNV.dat',nV,',');
  dlmwrite('config/matM.dat',M,',');
end
