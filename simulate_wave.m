netDim = 30; 
totalDim = 31;
samplelength = 550; 
linearNetwork = 1; 

intWM = result{1}.EstModel.AR{1};
inWM = result{1}.EstModel.a;
sampleout = result{1}.ERPon30ch;
input = 1;

totalstate =  zeros(totalDim,1);    
internalState = totalstate(1:netDim);
stateCollectMat = zeros(samplelength, totalDim);


plotindex = 0;
msetest = zeros(1,netDim); 
for i = 1:samplelength
    teach = sampleout(:,i);
    %update totalstate except at input positions  
    if linearNetwork
        internalState = ([intWM, inWM]*totalstate);  
%     else
%         internalState = f([intWM, inWM]*totalstate);  
    end
    
    totalstate = [internalState;input];    
    
    %collect states and results for later use in learning procedure
    stateCollectMat(i,:) = [internalState' input']; %fill a row

%     for j = 1:netDim
%         msetest(1,j) = msetest(1,j) + (teach(j,1)- internalState(j,1))^2;
%     end
    
%     %write plotting data into various plotfiles
%     if i > initialRunlength + sampleRunlength + freeRunlength 
%         plotindex = plotindex + 1;
%         if inputLength > 0
%             inputPL(:,plotindex) = in;
%         end
%         teacherPL(:,plotindex) = teach; 
%         netOutPL(:,plotindex) = netOut;
%         for j = 1:length(plotStates)
%             statePL(j,plotindex) = totalstate(plotStates(j),1);
%         end
%     end
end
%end of the great do-loop




% print diagnostics in terms of normalized RMSE (root mean square error)


% teacherVariance = var(teacherPL');
% disp(sprintf('train NRMSE = %s', num2str(sqrt(msetrain ./ teacherVariance))));
% disp(sprintf('test NRMSE = %s', num2str(sqrt(msetestresult ./ teacherVariance))));
% disp(sprintf('average output weights = %s', num2str(mean(abs(outWM')))));



% % plot overlay of network output and teacher  
% figure();
% subplot(netDim,1,1);   
% plot(1:samplelength,sampleout(1,:), 1:samplelength,stateCollectMat(1,:));
% title('teacher (blue) vs. net output (green)','FontSize',8);
% for k = 2:netDim
%     subplot(netDim,1,k);
%     plot(1:samplelength,sampleout(k,:), 1:samplelength,stateCollectMat(k,:));
% end  


