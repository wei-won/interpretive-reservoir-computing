%% specify data perameters

numChannel = 30;
numERP = 1000;
dataLength = 550;
scaleERP = false;
subjectSet = [22,23,24,25,26]; % Needs Specification [1,3,4,5,6,7,8,9,10,11] [12,13,14,15,16,17,18,19,20,21
numSubject = size(subjectSet,2);
sti1 = 'BWcelebs'; sti2 = 'BWfood'; sti3 = 'BWgabor';
sti4 = 'BWtext';sti5 = 'color'; sti6 = 'food';
stimuliSet = {sti1,sti2,sti5,sti6}; % Needs Specification {sti1,sti2,sti3,sti4,sti5,sti6}
numStimuli = size(stimuliSet,2);
erpId = 1:10; % Needs Specification
numSample = size(erpId,2);
dataPath = '../dataset_erp/';

saveSeparateRes = false; % Needs Specification
saveCombinedRes = true; % Needs Specification

%% Run on single subject with same stimuli

% loop through subjects
for subject_index = 1:numSubject
    subjectId = subjectSet(subject_index);
    
    % specify result path
    if scaleERP
        resPath = ['./results_simpleNet/scaledERP/subject',num2str(subjectId),'/combined_res/'];
    else
        resPath = ['./results_simpleNet/rawERP/subject',num2str(subjectId),'/combined_res/'];
    end
    
    % loop through stimuli categories
    for sti_index = 1:numStimuli
        stimuli = stimuliSet{sti_index};
        
        % load data
        load([dataPath,'avg20_sub',sprintf('%03d',subjectId),'a_',stimuli,'.mat']);
        
        % run VAR for each ERP on 30 channels
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
    end
end