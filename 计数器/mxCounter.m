function [ux,nx] = mxCounter(x)
% ��������
% ���룺
%   x  ����
% �����
%   ux Ԫ��
%   nx ����
[ux,~,ic] = unique(x(:));
ic=sort(ic);
ic=diff([0;ic;length(ux)+1]);
idx=find(ic==1);
nx=idx(2:end)-idx(1:(end-1));
end
