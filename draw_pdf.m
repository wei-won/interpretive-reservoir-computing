% Draw the PDF of similarity

load('../results/coef_collect_same_subj.mat');
% same_in = inCoefsCollect;
same_in = inCoefsCollect([1,2,5,6,7,10],:);
% same_int = intCoefsCollect;
same_int = intCoefsCollect([1,2,5,6,7,10],:);

%%
load('../results/coef_collect_diff_subj.mat');
% diff_in = inCoefsCollect;
diff_in = inCoefsCollect([1,2,5,6,7,10],:);
% diff_int = intCoefsCollect;
diff_int = intCoefsCollect([1,2,5,6,7,10],:);

same_in = reshape(same_in,1,[]);
same_int = reshape(same_int,1,[]);
diff_in = reshape(diff_in,1,[]);
diff_int = reshape(diff_int,1,[]);

%% for input

error_min=min(diff_in);
error_max=max(diff_in);
error_max_true=max(same_in);
error_x = linspace(error_min,error_max_true,20);
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
error_x = linspace(error_min,error_max_true,20);
error_count_diff=hist(diff_int,error_x);
error_count_same=hist(same_int,error_x);
 
error_density_diff=error_count_diff/length(diff_int);
error_density_same=error_count_same/length(same_int);
figure
plot(error_x,error_density_diff,'r');
hold on 
plot(error_x,error_density_same,'b');
 
hold off