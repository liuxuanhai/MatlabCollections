clc,clear,close all;
% ��ux�϶�ʱ
% map�������
% sort���
% qsort��֮
% mx�ѵ���ô��
x=rand([1000000,1]);
tic
[~,~]=mapCounter(x);
toc
tic
[~,~]=sortCounter(x);
toc
tic
[~,~]=qsortCounter(x);
toc
tic
[~,~]=mxCounter(x);
toc
% ��ux����ʱ
% map��sort���
% qsort�Բ�
% mx�ѵ���ô��
x=unidrnd(1000,[1000000,1]);
tic
[~,~]=mapCounter(x);
toc
tic
[~,~]=sortCounter(x);
toc
tic
[~,~]=qsortCounter(x);
toc
tic
[~,~]=mxCounter(x);
toc
% ������˵����ѡ��sort���