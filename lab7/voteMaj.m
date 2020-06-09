function [errcfs] = voteMaj(clslabels, tstl)
% simple majority classifier - winning class must have 50% + 1 votes
% clslabels - matrix containing elementary classifiers results
%	each row contains NN labels for one test element
% tstl - test set labels (ground truth)
% errcf - error coefficients of the classifier

	clsCount = columns(clslabels);
    #treshold 50% + 1
	treshold = floor(clsCount/2) + 1;
	reject = max(tstl) + 1; 

	[lab f] = mode(clslabels'); #most frequent class (how many classifiers voted for it)
#if for this votes for most frequent class are less then threshold - reject
	lab(f < treshold) = reject;
	
	confmx = confMx(tstl, lab);
	errcfs = compErrors(confmx);
