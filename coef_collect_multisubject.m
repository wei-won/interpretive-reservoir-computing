%%
% run analyze_same_sub_w/_same_sti.m

avgInt = cell(1,numSubject);
avgInput = cell(1,numSubject);
for i = 1:numSubject
    avgInt{i} = intCorrRes{2,numSubject+1};
    avgInput{i} = inputCorrRes{2,numSubject+1};
end

for i = 1:numSubject
    avgInt{i} = (sum(avgInt{i})-ones(1,numSample))/(numSample-1);
    avgInput{i} = (sum(avgInput{i})-ones(1,numSample))/(numSample-1);
    
end

same_int = cell2mat(avgInt);
same_in = cell2mat(avgInput);

%%
% run analyze_same_sub_w/_diff_sti.m

coef_collector;

diff_in = inCoefsCollect;
% diff_in = inCoefsCollect([1,2,5,6,7,10],:);
diff_int = intCoefsCollect;
% diff_int = intCoefsCollect([1,2,5,6,7,10],:);

diff_in = reshape(diff_in,1,[]);
diff_int = reshape(diff_int,1,[]);

%%

%% for input

error_min=min(diff_in);
error_max=max(diff_in);
error_max_true=max(same_in);
error_x = linspace(error_min,error_max_true,10);
error_count_diff=hist(diff_in,error_x);
error_count_same=hist(same_in,error_x);
 
error_density_diff=error_count_diff/length(diff_in);
error_density_same=error_count_same/length(same_in);
figure;
plot(error_x,error_density_diff,'r');
hold on 
plot(error_x,error_density_same,'b');
 
hold off

%% for internal

error_min=min(diff_int);
error_max=max(diff_int);
error_max_true=max(same_int);
error_x = linspace(error_min,error_max_true,100);
error_count_diff=hist(diff_int,error_x);
error_count_same=hist(same_int,error_x);
 
error_density_diff=error_count_diff/length(diff_int);
error_density_same=error_count_same/length(same_int);
figure;
plot(error_x,error_density_diff,'r');
hold on 
plot(error_x,error_density_same,'b');
 
hold off