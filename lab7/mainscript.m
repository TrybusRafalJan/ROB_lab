vnames = {
'valid_1.txt', 
'valid_2.txt',
'valid_3.txt', 
'valid_4.txt', 
'valid_5.txt', 
'valid_6.txt', 
'valid_7.txt'};

tnames = {
'test_1.txt', 
'test_2.txt', 
'test_3.txt', 
'test_4.txt', 
'test_5.txt', 
'test_6.txt', 
'test_7.txt'};
	
vtab = loadCNNOutputs(vnames);
load validlab.txt
validlab = validlab + 1;

ttab = loadCNNOutputs(tnames);
load testlab.txt
testlab = testlab + 1;

iqltytest = [];
iqltyvald = [];
#check how many correct elements
# validlab , testlab contains ground truth labels
# vtab, ttab contains labels being a result of classification
for i=1:columns(vtab)
	iqltyvald = [iqltyvald sum(vtab(:,i)!=validlab)/rows(validlab)];
	iqltytest = [iqltytest sum(ttab(:,i)!=testlab)/rows(testlab)];
end


eff = [1-iqltyvald; 1-iqltytest]

vecUni = voteUni(vtab, validlab);
vecMaj = voteMaj(vtab, validlab);
vecPlr = votePlr(vtab, validlab);
vecWeight = voteWeight(vtab,validlab,eff(1,:));

tecUni = voteUni(ttab, testlab);
tecMaj = voteMaj(ttab, testlab);
tecPlr = votePlr(ttab, testlab);
tecWeight = voteWeight(ttab,testlab,eff(2,:));

resVald = [vecUni; vecMaj; vecPlr; vecWeight];
resTest = [tecUni; tecMaj; tecPlr; tecWeight];

resVald = [resVald fobj(resVald)]
resTest = [resTest fobj(resTest)]



