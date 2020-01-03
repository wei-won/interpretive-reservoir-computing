% specify data perameters

scaleERP = false;

subjectSet = [1,6,8,11,13,16,21,23,24,25]; % Needs Specification [1,3,4,5,6,7,8,9,10,11]
numSubject = size(subjectSet,2);
sti1 = 'BWcelebs'; sti2 = 'BWfood'; sti3 = 'BWgabor';
sti4 = 'BWtext';sti5 = 'color'; sti6 = 'food';
stimuliSet = {sti6}; % Needs Specification
numStimuli = size(stimuliSet,2);
erpId = 1:10; % Needs Specification
numSample = size(erpId,2);
stimuli = 'BWcelebs';

saveCorrRes = false; % Needs Specification

% specify load path
if scaleERP
    loadPath = ['./results_simpleNet/scaledERP/'];
    resPath = ['./results_simpleNet/scaledERP/corrAnaly/'];
else
    loadPath = ['./results_simpleNet/rawERP/'];
    resPath = ['./results_simpleNet/rawERP/corrAnaly/'];
end

% load combined results
for subject_count = 1:numSubject
    subject_id = subjectSet(subject_count);
    load([loadPath,'subject',num2str(subject_id),'/combined_res/',...
            'CombinedVarRes_sub_',num2str(subject_id),'_',stimuli,'_',...
                num2str(numSample),'_erps','.mat']);
            
%     load(['/Users/metoo/Documents/experiment/erp+esn/results/subject',...
%        num2str(subject_id),'/',stimuli,'/','CombinedVarRes_sub_',...
%        num2str(subject_id),'_',stimuli,'_10_erps.mat']);
   
    % collect internal weight matrics and input constants
    intWMs{1,subject_count} = result{10}.EstModel.AR{1};
    inputConst(:,subject_count) = result{10}.EstModel.a;
end


% analyze the similarity
for i = 1:numSubject
   for j = 1:numSubject
       % correlation coefficients
       corrcoefMatIntWMs(i,j) =  corr2(intWMs{i},intWMs{j});
       corrcoefMatInput(i,j) = corr2(inputConst(:,i),inputConst(:,j));
       
%        % distance
%        distCollectIntWMs{i,j} = intWMs{i}-intWMs{j};
%        distCollectInput{i,j} = inputConst(:,i)-inputConst(:,j);
%        
%        % mutual information
%        miMatIntWMs(i,j) = mi(intWMs{i},intWMs{j},100);
%        miMatInput(i,j) = mi(inputConst(:,i),inputConst(:,j),100);
   end
end


corrcoefMatIntWMs = abs(corrcoefMatIntWMs);
corrcoefMatInput = abs(corrcoefMatInput);