% A1 = [.5 0 0;.1 .1 .3;0 .2 .3];
% Q = eye(3);
% Mdl = vgxset('a',[.05;0;-.05],'AR',{A1},'Q',Q);

Mdl = vgxset('ARsolve',{logical(eye(3))},'a',...
    [.05;0;-.05])