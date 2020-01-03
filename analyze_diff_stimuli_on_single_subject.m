% specify data perameters

scaleERP = false;
subjectSet = [1,3,4,5,6,7,8,9,10,11]; % Needs Specification [1,3,4,5,6,7,8,9,10,11]
numSubject = size(subjectSet,2);
sti1 = 'BWcelebs'; sti2 = 'BWfood'; sti3 = 'BWgabor';
sti4 = 'BWtext';sti5 = 'color'; sti6 = 'food';
stimuliSet = {sti1,sti2,sti3,sti4,sti5,sti6}; % Needs Specification
numStimuli = size(stimuliSet,2);
erpSet = 1:10; % Needs Specification
numSample = size(erpSet,2);
erp_id = 1;

saveCorrRes = false; % Needs Specification

% specify load path
if scaleERP
    loadPath = ['./results_simpleNet/scaledERP/'];
    resPath = ['./results_simpleNet/scaledERP/corrAnaly/'];
else
    loadPath = ['./results_simpleNet/rawERP/'];
    resPath = ['./results_simpleNet/rawERP/corrAnaly/'];
end

inputCorrRes = cell(2,numSubject);
inputCorrRes(1,:) = num2cell(subjectSet);
intCorrRes = inputCorrRes;

% subject_id = 1; % Needs Specification

for subject_count = 1:numSubject
    subject_id = subjectSet(subject_count);

    % load combined results
    for stimuliCount = 1:numStimuli
        stimuli = stimuliSet{stimuliCount};
        
        load([loadPath,'subject',num2str(subject_id),'/combined_res/',...
            'CombinedVarRes_sub_',num2str(subject_id),'_',stimuli,'_',...
                num2str(numSample),'_erps','.mat']);
        
%         load(['./results/subject',...
%            num2str(subject_id),'/',stimuliInstance,'/','CombinedVarRes_sub_',...
%            num2str(subject_id),'_',stimuliInstance,'_10_erps.mat']);

        % collect internal weight matrics and input constants
        intWMs{1,stimuliCount} = result{erp_id}.EstModel.AR{1};
        inputConst(:,stimuliCount) = result{erp_id}.EstModel.a;
    end


    % analyze the similarity
    for i = 1:numStimuli
       for j = 1:numStimuli
           % correlation coefficients
           corrcoefMatIntWMs(i,j) =  corr2(intWMs{i},intWMs{j});
           corrcoefMatInput(i,j) = corr2(inputConst(:,i),inputConst(:,j));

    %        % distance
    %        distCollectIntWMs{i,j} = intWMs{i}-intWMs{j};
    %        distCollectInput{i,j} = inputConst(:,i)-inputConst(:,j);

    %        % mutual information
    %        miMatIntWMs(i,j) = mi(intWMs{i},intWMs{j},100);
    %        miMatInput(i,j) = mi(inputConst(:,i),inputConst(:,j),100);
       end
    end

    inputCorrRes{2,subject_count} = corrcoefMatInput;
    intCorrRes{2,subject_count} = corrcoefMatIntWMs;
    
end


%% filter result and analysis

goodSubj = [1,5,7]; % 1,6,8,
num_goodSubj = length(goodSubj);


sumInputOverSub = zeros(numStimuli);
sumIntOverSub = sumInputOverSub;

for subject_count = 1:num_goodSubj
    
    sumInputOverSub = sumInputOverSub + inputCorrRes{2,goodSubj(subject_count)}; 
    sumIntOverSub = sumIntOverSub + intCorrRes{2,goodSubj(subject_count)};
end
     
inputAvgBetweenSti = sumInputOverSub/num_goodSubj;
intAvgBetweenSti = sumIntOverSub/num_goodSubj;