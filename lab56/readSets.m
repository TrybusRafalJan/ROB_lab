function [tvec tlab tstv tstl] = readSets()
% Reads training and testing sets of the MNIST database
%  assumes that files are in the current directory

	fnames = { 'train-images.idx3-ubyte'; 'train-labels.idx1-ubyte';  
				't10k-images.idx3-ubyte'; 't10k-labels.idx1-ubyte' };

	[tlab tvec] = readmnist(fnames{1,1}, fnames{2,1});
	[tstl tstv] = readmnist(fnames{3,1}, fnames{4,1});
  
  M = rows(tvec);
  index_new = randperm(M);
  tvec = tvec(index_new,:);
  tlab = tlab(index_new,:);
  
  mean_val = mean(tvec);
  std_val = std(tvec);
  std_val(std_val==0) = 1;
  tvec = bsxfun(@minus,tvec,mean_val);
  tvec = bsxfun(@rdivide,tvec,std_val);
  tstv = bsxfun(@minus,tstv,mean_val);
  tstv = bsxfun(@rdivide,tstv,std_val);
