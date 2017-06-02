function [r,L,U] = pdfrnd(pdf,sz,m,e,mu)
% �Զ���pdf���������������
% �������ΧΪ(-inf,inf)
% ����������ɢ���ķ������ҵ�0-1�ֲ�������������������䣬���������ڵ�һ�����ȷֲ��������
% ���룺
%   pdf �����ܶȺ�����ֵ�����Ա�����û�в���
%   sz  ����������С
%   m   pdf�������������ѡ��Ĭ��1e4
%   e   pdf���������½紦��pdfֵ��Ĭ��1e-3
%   mu  �������ֵ����ѡ��Ĭ��0
% �����
%   r   �������������������
if nargin<5
    mu=0;
    if nargin<4
        e=1e-3;
        if nargin<3
            m=1e4;
        end
    end
end
n=prod(sz);
L=fzero(@(x)pdf(x)-e,mu-10);
U=fzero(@(x)pdf(x)-e,mu+10);
D=U-L;
while integral(pdf,L,U)<1-1/m
    L=L-D/10;
    U=U+D/10;
end
LL=L-(U-L)/m;
UU=U+(U-L)/m;
x=linspace(L,U,m);
y=pdf(x);
c=cumtrapz(x,y);
rc=(1-c(end))/2;
c=[0,c+rc,1];
x=[LL,x,UU];
ur=rand([1,n]);
[~,ind]=sort([c,ur]);
lb=mexGetLB(ind,length(c),length(ur));
r=unifrnd(x(lb),x(lb+1));
r=reshape(r,sz);
end