function MdlResult = runvar(erpDataSet,stimuli,numChannel,numERP,subjectId,erpInstance,saveSeparateRes,resPath,scaleERP)

for i = 1:numChannel;
    data(i,:) = erpDataSet(numERP*(i-1)+erpInstance,3:end); 
    if scaleERP
        % normalize output to range [-1,1]
        maxVal = max(data(i,:)); 
        minVal = min(data(i,:));
        if maxVal - minVal > 0
            data(i,:) = 2 * (data(i,:) - minVal)/(maxVal - minVal) - 1;
        end
    end
end
Y = data';

% creat a multivariate model
Mdl = vgxset('n',numChannel,'nAR',1,'Constant',true);

% estimate matrices (fit model to data)
[EstMdl,EstStdErrors,LLF,W] = vgxvarx(Mdl,Y);

% vgxdisp(EstMdl);
[isStable, isInvertible] = vgxqual(EstMdl);

% collect results
MdlResult.subjectId = subjectId;
MdlResult.stimuli = stimuli;
MdlResult.erpInstance = erpInstance;
MdlResult.ERPon30ch = data;
MdlResult.Model = Mdl;
MdlResult.EstModel = EstMdl;
MdlResult.EstStdErrors = EstStdErrors;
MdlResult.LLF = LLF;
MdlResult.W = W;
MdlResult.isStable = isStable;
MdlResult.isInvertible = isInvertible;

% save results
if saveSeparateRes
    if ~exist(resPath,'dir')
        mkdir(resPath);
    end
    save([resPath,'varRes_sub_',num2str(subjectId),'_',stimuli,'_erp_',...
        num2str(erpInstance),'.mat'],'erpInstance','data','Mdl',...
        'EstMdl','EstStdErrors','LLF','W','isStable','isInvertible');
end
