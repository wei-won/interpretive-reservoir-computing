clear
% specify data perameters
numChannel = 30;
numERP = 1000;
subjectId = 1; % Needs Specification
stimuli = 'BWcelebs'; % Needs Specification
erpId4Input = 1; % Needs Specification
erpId4newMdl = 2; % Needs Specification
resPath = ['./results/subject',num2str(subjectId),'/',stimuli,'/forcast/'];
saveRes = false; % Needs Specification

% load data set (for one subject on one stimuli class) and retrive 1st ERPs
% of all 30 channels
% load('/Users/metoo/Documents/experiment/erp+esn/dataset_erp/avg20_sub001a_BWgabor.mat'); % Needs Specification
load('../dataset_erp/avg20_sub001a_BWcelebs.mat'); % Needs Specification
dataLength = size(avg,2)-2;
trainLength = 450; % Needs Specification
testLength = dataLength - trainLength;

% load the combined result
load(['../results/subject',...
       num2str(subjectId),'/',stimuli,'/','CombinedVarRes_sub_',...
       num2str(subjectId),'_',stimuli,'_10_erps.mat']);

% retrieve input data
intWM = result{erpId4Input}.EstModel.AR{1};
   
% collect training data
for i = 1:numChannel;
   data(i,:) = avg(numERP*(i-1)+erpId4newMdl,3:2+trainLength); 
   data2(i,:) = avg(numERP*(i-1)+erpId4newMdl,3+trainLength:end);
end
trainData = data';
testData = data2';
   

% run vector autoregressive with given input
disp(['Estimating model ',num2str(erpId4newMdl),' based on the internal weight matrix of model ',num2str(erpId4Input),'...']);
erpInstance = [num2str(erpId4newMdl),'from',num2str(erpId4Input)];
result = runvar_with_input(trainData,testData,stimuli,numChannel,subjectId,erpInstance,intWM,testLength);

% plot
figure();
for i = 1:10
    subplot(10,3,i);
    plot(testData(:,i));
    hold on
    plot(result.forecast(:,i));
    hold off
end

% figure();
for i = 11:20
    subplot(10,3,i);
    plot(testData(:,i));
    hold on
    plot(result.forecast(:,i));
    hold off
end

% figure();
for i = 21:30
    subplot(10,3,i);
    plot(testData(:,i));
    hold on
    plot(result.forecast(:,i));
    hold off
end

% save results as single file
if saveRes
    save([resPath,'ForecastVarRes_sub_',num2str(subjectId),'_',stimuli,'_',...
        result.erpInstance,'.mat'],'numChannel','numERP',...
        'subjectId','stimuli','numSample','erpId','result');
end