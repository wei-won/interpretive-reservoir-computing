% load data set (for one subject on one stimuli class) and retrive 1st ERPs
% of all 30 channels
load('/Users/metoo/Documents/experiment/erp+esn/dataset_erp/avg20_sub001a_BWcelebs.mat');

% specify data perameters
numChannel = 30;
numERP = 1000;
dataLength = size(avg,2)-2;

for i = 1:30;
   data(i,:) = avg(numERP*(i-1)+1,3:end); 
end
Y = data';

% creat a multivariate model
Mdl = vgxset('n',numChannel,'nAR',1,'Constant',true);

% estimate matrices (fit model to data)
[EstMdl,EstStdErrors,LLF,W] = vgxvarx(Mdl,Y);
% vgxdisp(EstMdl);
[isStable, isInvertible] = vgxqual(EstMdl);