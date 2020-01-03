% %% ????  
% load 14cancer.mat  
% data = [Xtrain(find(ytrainLabels==9),genesSet); Xtest(find(ytestLabels==9),genesSet)];  
  
%% ?????100?????????????  
% Z_x = linkage(pdist(a));  
% Z_y = linkage(pdist(a'));  

Z_x = linkage(b);  
Z_y = linkage(b');  
  
%% ??????  
figure('units','normalized','Position',[0.5641    0.2407    0.3807    0.6426]);  
mainPanel = axes('Position',[.25 .08 .69 .69]);  
leftPanel = axes('Position',[.08 .08 .17 .69]);  
topPanel =  axes('Position',[.25 .77 .69 .21]);  
  
%% ????????  
m = colormap(pink); m = m(end:-1:1,:);  
colormap(m);  
  
%% ?????? - ?????????????????0?????????30????  
axes(leftPanel);h = dendrogram(Z_y,'orient','left'); set(h,'color',[0.1179         0         0],'linewidth',2);  
axes(topPanel); h = dendrogram(Z_x,0);set(h,'color',[0.1179         0         0],'linewidth',2);  
  
%% ????????????????  
Z_samples_order = str2num(get(leftPanel,'yticklabel'));  
Z_genes_order = str2num(get(topPanel,'xticklabel'));  
axes(mainPanel);  
surf(a(Z_samples_order,Z_genes_order),'edgecolor',[.8 .8 .8]);view(2);  
set(mainPanel,'Xticklabel',[],'yticklabel',[]);  
  
%% ??X??Y?  
set(leftPanel,'ylim',[1 size(a,1)],'Visible','Off');  
set(topPanel,'xlim',[1 size(a,2)],'Visible','Off');  
axes(mainPanel);axis([1 size(a,2) 1 size(a,1)]);  
  
%% ????  
axes(mainPanel); xlabel('30??????','Fontsize',14);   
colorbar('Location','northoutside','Position',[ 0.0584    0.8761    0.3082    0.0238]);   
annotation('textbox',[.5 .87 .4 .1],'String',{'??????', '???'},'Linestyle','none','fontsize',14);  
  
%% ????????????????  
set(leftPanel,'yaxislocation','left');  
set(get(leftPanel,'ylabel'),'string','??','Fontsize',14);  
set(findall(leftPanel, 'type', 'text'), 'visible', 'on');  
  
set(gcf,'color',[1 1 1],'paperpositionmode','auto');  