#!/usr/bin/octave -qf

#faces = dlmread("dfFaces_21x21.fmt.norm", ",");
#no_faces = dlmread("NotFaces_21x21.fmt.norm", ",");

if (nargin != 0)
  printf("Usage: train_face_detector <num_regions>\n");
endif
  
arg_list = argv();
nregions = str2num(arg_list{1});
