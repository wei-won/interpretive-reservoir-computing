%% specify data perameters
% load combined results
% load('/Users/metoo/Documents/experiment/erp+esn/results/subject1/BWcelebs/CombinedVarRes_sub_1_BWcelebs_10_erps.mat');
% load('./results/subject4/BWcelebs/CombinedVarRes_sub_4_BWcelebs_10_erps.mat');

scaleERP = false;
subjectSet = [1,6,8,11,13,16,21,23,24,25]; % Needs Specification [1,3,4,5,6,7,8,9,10,11] [12,13,14,15,16,17,18,19,20,21] [22,23,24,25,26]
numSubject = size(subjectSet,2);
sti1 = 'BWcelebs'; sti2 = 'BWfood'; sti3 = 'BWgabor';
sti4 = 'BWtext';sti5 = 'color'; sti6 = 'food';
stimuliSet = {sti6}; % Needs Specification {sti1,sti2,sti3,sti4,sti5,sti6}
numStimuli = size(stimuliSet,2);
erpSet = 1:10; % Needs Specification
numSample = size(erpSet,2);
% sti = 'BWcelebs'; % 'BWcelebs', 'BWfood', 'BWgabor', 'BWtext', 'color', 'food';
% subjectId = 1;

saveCorrRes = false; % Needs Specification

% specify load path
if scaleERP
    loadPath = ['./results_simpleNet/scaledERP/'];
    resPath = ['./results_simpleNet/scaledERP/corrAnaly/'];
else
    loadPath = ['./results_simpleNet/rawERP/'];
    resPath = ['./results_simpleNet/rawERP/corrAnaly/'];
end
% loadPath = ['./results/subject', num2str(subjectId), '/', sti, '/CombinedVarRes_sub_', num2str(subjectId), '_', sti,'_10_erps.mat'];
% load(loadPath);

inputCorrRes = cell(numStimuli+1,numSubject+1);
inputCorrRes(1,2:numSubject+1) = num2cell(subjectSet);
inputCorrRes(2:numStimuli+1,1) = stimuliSet';
intCorrRes = inputCorrRes;

% loop through subjects
for subject_count = 1:numSubject
    subject_id = subjectSet(subject_count);
    
    % loop through stimuli categories
    for sti_count = 1:numStimuli
        stimuli = stimuliSet{sti_count};
        
        % load data
        load([loadPath,'subject',num2str(subject_id),'/combined_res/',...
            'CombinedVarRes_sub_',num2str(subject_id),'_',stimuli,'_',...
                num2str(numSample),'_erps','.mat']);
            
        % collect internal weight matrics and input constants
        for i = 1:numSample
            intWMs{1,i} = result{i}.EstModel.AR{1};
            inputConst(:,i) = result{i}.EstModel.a;
        end

        % analyze the similarity
        for i = 1:numSample
            for j = 1:numSample
                % correlation coefficients
                corrcoefMatIntWMs(i,j) =  corr2(intWMs{i},intWMs{j});
                corrcoefMatInput(i,j) = corr2(inputConst(:,i),inputConst(:,j));
       
%                % distance
%                distCollectIntWMs{i,j} = intWMs{i}-intWMs{j};
%                distCollectInput{i,j} = inputConst(:,i)-inputConst(:,j);
%        
%                % mutual information
%                miMatIntWMs(i,j) = mi(intWMs{i},intWMs{j},100);
%                miMatInput(i,j) = mi(inputConst(:,i),inputConst(:,j),100);
                

            end
        end
        inputCorrRes{sti_count+1,subject_count+1} = corrcoefMatInput;
        intCorrRes{sti_count+1,subject_count+1} = corrcoefMatIntWMs;
    end
end



%% filter result and analysis

inputAvgPerSubSti = cell(numStimuli+1,numSubject+1);
inputAvgPerSubSti(1,2:numSubject+1) = num2cell(subjectSet);
inputAvgPerSubSti(2:numStimuli+1,1) = stimuliSet';
intAvgPerSubSti = inputAvgPerSubSti;

for subject_count = 1:numSubject
    for sti_count = 1:numStimuli
        inputAvgPerSubSti{sti_count+1,subject_count+1} = ...
            (sum(sum(inputCorrRes{sti_count+1,subject_count+1}))-numSample)...
            /(numel(inputCorrRes{sti_count+1,subject_count+1})-numSample);
        
        intAvgPerSubSti{sti_count+1,subject_count+1} = ...
            (sum(sum(intCorrRes{sti_count+1,subject_count+1}))-numSample)...
            /(numel(intCorrRes{sti_count+1,subject_count+1})-numSample);
        
    end
end


%% save results as single file
if saveCorrRes
    if ~exist(resPath,'dir')
        mkdir(resPath);
    end
    save([resPath,'corrcoefRes_Ssubj_Ssti_',num2str(numSample),'_erps','.mat'],...
        'subjectSet','stimuliSet','erpId','scaleERP','inputCorrRes','intCorrRes',...
        'inputAvgPerSubSti','intAvgPerSubSti');
end

% %%
% 
% for i = 1:10
% Mint(1,i)=max(max(intCorrRes{2,i+1}));
% Minput(1,i)=max(max(inputCorrRes{2,i+1}));
% mint(1,i)=min(min(intCorrRes{2,i+1}));
% minput(1,i)=min(min(inputCorrRes{2,i+1}));
% end