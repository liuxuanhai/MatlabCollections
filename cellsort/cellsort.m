function x=cellsort(x,cols)
% �� cell ���鰴������
% ���룺
%     x cell ����
%     cols ����ţ�����ָ������������������ʾ���򣬸�����ʾ����
% �����
%     x ������
% ����
%     cellsort(x,[2,1,-3]) 
% ���ΰ��յ� 2 1 3 �н����������� 2 1 ����3 ����
n=length(cols);
inds=cell(1,n);
dirs=cell(1,n);
for k=1:n
    if cols(k)>0
        dirs{k}='ascend';
    else
        dirs{k}='descend';
    end
    j=abs(cols(k));
    if iscellstr(x(:,j))
        [~,~,inds{k}]=unique(x(:,j));
    else
        [~,~,inds{k}]=unique(cell2mat(x(:,j)));
    end
end
[~,ind]=sortrows(cell2mat(inds),1:n,dirs);
x=x(ind,:);
end