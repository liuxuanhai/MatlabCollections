%% ��ȡ����
clc,clear,close all;
[~,~,x]=xlsread('1.xlsx');
%% ��ȡ����
y=str2double(x(1,3:end));% ���
x(1,:)=[];
ck=x(:,1);% ���ڹ�
jk=x(:,2);% ���ڹ�
d=x(:,3:end);% ��ȡ���ݣ���ʱ����cell���ں��ַ��������֣�����ֱ�� cell2mat
[m,n]=size(d);
dd=zeros(m,n);
for i=1:m
    for j=1:n
        if isscalar(d{i,j})
            dd(i,j)=d{i,j};
        else
            dd(i,j)=NaN;
        end
    end
end
%% ��ȡ���Һ����
[uck,~,id]=unique(ck);
yid=[1,11,21,31:37];
nc=length(uck);
ny=length(yid);
%% �洢����ĸ�ʽ
res=cell(nc,1);
%% ���ݴ���
for i=1:nc
    ind=id==i;% ��ȡ��ĳ�����ҳ��ڵ����������еı��
    xx=dd(id==i,yid);% ��Ӧ����
    sgj=jk(ind);% ��Ӧ����
    [sj,ii]=sort(-xx);% �������򣬴Ӵ�С��NaN����󣬻�ȡ����ı��
    gj=sgj(ii);% �����Ұ�˳�����У�����Ӧ���������ľ����±���ʹ���
    sj=num2cell(-sj);% �����ݴӾ�����cell
    % ���ʱ��Ҫ��gj �� sj �������в�����Ҫ�Ľ�����԰ɣ���ô������ 2*ny
    nn=length(gj);% ������ҹ��ж��ٸ����ڹ�
    rr=cell(nn,2*ny);
    for j=1:ny
        rr(:,2*j-1)=gj(:,j);% �������ǹ���
        rr(:,2*j)=sj(:,j);
    end
    cks=cell(nn,1);
    cks{1}=ck{ind};
    res{i}=[cks,...% ���ϳ��ڹ�
        num2cell((1:nn)'),...% ��������
        rr];% �����������ҵĽ��
end
%% ��󽫽������ƴ�Ӳ����
res=cat(1,res{:});
% Ȼ��������������
% ���ڹ���������1980���գ�1990���գ�����
ys=[num2cell(y(yid));cell(1,ny)];
lm1=[{'���ڹ�','����'},ys(:)'];
% �գ��գ� ���ң�����ȣ����ң�����ȣ�����
lm2=[cell(1,2),repmat({'����','�����'},[1,ny])];
res=[lm1;lm2;res];
%% ����
% xlswrite('res.xlsx',res);
xls_merge_write('./res.xlsx',res,1,[1,2]);