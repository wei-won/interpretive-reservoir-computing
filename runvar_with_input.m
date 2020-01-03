function MdlResult = runvar_with_input(trainData,testData,stimuli,numChannel,subjectId,erpInstance,AR,testLength)

% creat a multivariate model with internal weight matrix inherited from
% estimated model
% Mdl = vgxset('n',numChannel,'nAR',1,'Constant',true,'AR',AR);
Mdl = vgxset('Constant',true,'ARsolve',{false(numChannel)},'AR',AR);

% estimate matrices (fit model to data)
[EstMdl,EstStdErrors,LLF,W] = vgxvarx(Mdl,trainData);

% vgxdisp(EstMdl);
[isStable, isInvertible] = vgxqual(EstMdl);

% predict the test data based on the estimated new model
% [forecast,forecastCov] = vgxpred(EstMdl,testLength,[],trainData,W);
% [forecast,forecastCov] = vgxsim(EstMdl,testLength,[],trainData,W);
[forecast,forecastCov] = vgxsim(EstMdl,testLength);

% collect results
MdlResult.subjectId = subjectId;
MdlResult.stimuli = stimuli;
MdlResult.erpInstance = erpInstance;
MdlResult.trainData = trainData;
MdlResult.testData = testData;
MdlResult.Model = Mdl;
MdlResult.EstModel = EstMdl;
MdlResult.EstStdErrors = EstStdErrors;
MdlResult.LLF = LLF;
MdlResult.W = W;
MdlResult.isStable = isStable;
MdlResult.isInvertible = isInvertible;
MdlResult.forecast = forecast;
MdlResult.forecastCov = forecastCov;

% % save results
% if saveSeparateRes
%     save([resPath,'varRes_sub_',num2str(subjectId),'_',stimuli,'_erp_',...
%         erpInstance,'.mat'],'erpInstance','data','Mdl',...
%         'EstMdl','EstStdErrors','LLF','W','isStable','isInvertible');
% end
