% load data set (for one subject on one stimuli class) and retrive 1st ERPs
% of all 30 channels
% load('/Users/metoo/Documents/experiment/erp+esn/dataset_erp/avg20_sub001a_BWgabor.mat'); % Needs Specification
load('../dataset_erp/avg20_sub004a_BWfood.mat'); % Needs Specification
stimuli = 'BWfood'; % Needs Specification

% specify data perameters
numChannel = 30;
numERP = 1000;
dataLength = size(avg,2)-2;
scaleERP = false;
subjectId = 1; % Needs Specification
erpId = 1; % Needs Specification
numSample = size(erpId,2);
if scaleERP
    resPath = ['./results_simpleNet/scaledERP/subject',num2str(subjectId),'/',stimuli,'/'];
else
    resPath = ['./results_simpleNet/rawERP/subject',num2str(subjectId),'/',stimuli,'/'];
end
saveSeparateRes = false; % Needs Specification
saveCombinedRes = false; % Needs Specification

% run vector autoregressive for each erp on 30 channels
for itr = 1:numSample
    disp(['Estimating model: Subject_',num2str(subjectId),'; stimuli_',stimuli,...
        '; ERP ',num2str(itr),'/',num2str(numSample),'...']);
    erpInstance = erpId(itr);
    result{itr,1} = runvar(avg,stimuli,numChannel,numERP,subjectId,erpInstance,saveSeparateRes,resPath,scaleERP);
end

% save results as single file
if saveCombinedRes
    if ~exist(resPath,'dir')
        mkdir(resPath);
    end
    save([resPath,'CombinedVarRes_sub_',num2str(subjectId),'_',stimuli,'_',...
        num2str(numSample),'_erps','.mat'],'numChannel','numERP',...
        'subjectId','stimuli','numSample','erpId','result','scaleERP');
end