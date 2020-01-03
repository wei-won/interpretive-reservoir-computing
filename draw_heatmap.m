%% Draw Heatmap of Corr. Coef. Matrix

close all;
subject_id = 8;
datapath = ['./results_simpleNet/rawERP/subject',num2str(subject_id),...
    '/combined_res/CombinedVarRes_sub_',num2str(subject_id),'_food_10_erps.mat'];
load(datapath);
% ch_arrange = [3,2,4,7,9,5,8,6,14,10,12,13,11,15,1,19,17,16,20,18,22,23,25,21,24,26,28,30,29,27];
% ch_arrange = [2,3,6,8,5,9,7,4,15,11,13,12,10,14,18,20,16,17,19,1,23,25,21,24,22,26,28,29,27,30];
ch_arrange_x = [7,4,9,8,5,3,6,2,23,25,21,24,22,14,10,18,20,12,16,17,13,11,19,1,15,26,28,29,27,30];
ch_arrange_y = [14,18,17,20,16,25,24,21,9,8,5,10,11,19,13,12,1,23,22,15,7,4,3,6,2,26,28,29,27,30];

% ch_arrange_x = [7,6,8,4,5,2,3,9,14,12,10,18,20,16,17,11,19,13,1,15,23,25,21,24,22,26,28,29,27,30];
% ch_arrange_y = [7,6,8,4,5,2,3,9,14,12,10,18,20,16,17,11,19,13,1,15,23,25,21,24,22,26,28,29,27,30];

data = zeros(30,30);
for i = 1:10
    data = data + abs(result{i}.EstModel.AR{1,1});
end

data = data/10;

surf(data(ch_arrange_y,ch_arrange_x));view(2);
colormap(parula)
set(gca,'xtick', 1:30, 'xticklabel', ch_arrange_x);
set(gca,'ytick', 1:30, 'yticklabel', ch_arrange_y);
% figure;
% surf(data);view(2);
% set(gca,'xtick', 1:30);
% set(gca,'ytick', 1:30);
% figure;
% HeatMap(data,'Colormap',winter);
% pcolor(data);