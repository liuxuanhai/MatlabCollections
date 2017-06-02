function snake()
clc,clear,close all;
global curDir snakeList foodList cSnake cFood scale...
    UP DOWN LEFT RIGHT N isRunning
isRunning=true;
N=20;% �����С
cSnake=[0,1,0];
cFood=[1,0,0];
scale=20;
UP=[-1,0];
DOWN=[1,0];
LEFT=[0,-1];
RIGHT=[0,1];
% ��ʼ��
snakeList=java.util.ArrayList();
foodList=java.util.ArrayList();
curDir=UP;
head=unidrnd(N-2,1,2)+1;
next=head+DOWN;
snakeList.add(head);
snakeList.add(next);
foodList.add(unidrnd(N,1,2));
% ��������
f=figure('Name','̰����','NumberTitle','off');
set(f,'KeyPressFcn',@(~,event,~)contrlSnake(event));
displaySnake();
% �����߳�
t=timer;
t.Period=0.15;
t.BusyMode='queue';
t.ExecutionMode='fixedRate';
t.TimerFcn=@(tObj,~)autoMove(tObj);
t.ErrorFcn=@(obj,event)disp(event);
t.startDelay=1;
t.startFcn=@(~,~)title('Go!');
start(t);
title('Ready?');
set(f,'DeleteFcn',@(~,~,~)stop(t));
end
%--------------------------------------------------------------------------
function moveSnake()
% ���ƶ�
global snakeList curDir foodList N isRunning
head=snakeList.get(0);
head=head'+curDir;
snakeList.add(0,head);
ind=eatFood();
if isempty(ind)
    snakeList.remove(snakeList.size()-1);
else
    foodList.remove(ind-1);
    [I,J]=list2sub(snakeList);
    while true
        food=unidrnd(N,1,2);
        i=food(1);j=food(2);
        if ~any(i==I & j==J)
            break;
        end
    end
    foodList.add(food);
end
if isAlive()
    displaySnake();
else
    isRunning=false;
    title(sprintf('��Ϸ����,�÷�:%d',snakeList.size()-2));
end
end
%--------------------------------------------------------------------------
function ind = eatFood()
% ��ʳ��
global snakeList foodList
[I,J]=list2sub(foodList);
head=snakeList.get(0);
i=head(1);j=head(2);
ind=find(I==i & J==j);
end
%--------------------------------------------------------------------------
function b = isAlive()
% ����Ƿ����
b=true;
global snakeList N
[I,J]=list2sub(snakeList);
head=snakeList.get(0);
i=head(1);j=head(2);
% �����߽�
if i<1 || i>N || j<1 || j>N
    b=false;
end
% �Խ�
ind=I==i & J==j;
if any(ind(2:end))
    b=false;
end
end
%--------------------------------------------------------------------------
function contrlSnake(event)
% ���̼�������
global UP DOWN LEFT RIGHT curDir isRunning
if isRunning
    if strcmp(event.Key,'uparrow')
        dir=UP;
    elseif strcmp(event.Key,'downarrow')
        dir=DOWN;
    elseif strcmp(event.Key,'leftarrow')
        dir=LEFT;
    elseif strcmp(event.Key,'rightarrow')
        dir=RIGHT;
    end
    if checkDir(dir)
        curDir=dir;
    end
end
end
%--------------------------------------------------------------------------
function b = checkDir(dir)
% ����ƶ������Ƿ�Ϸ�
global snakeList
head=snakeList.get(0);
next=snakeList.get(1);
b=~(isequal(next-head,dir')||isequal(next-head,-dir'));
end
%--------------------------------------------------------------------------
function autoMove(tObj)
% �߳����к���
global isRunning
if isRunning
    moveSnake();
else
    stop(tObj);
end
end
%--------------------------------------------------------------------------
function displaySnake()
% ����ͼ��
% ����ת��Ϊ����
global N snakeList cSnake foodList cFood scale
M=ones(N,N,3);
[I,J]=list2sub(snakeList);
M(I(1),J(1),:)=[0,0.8,0];
for k=2:length(I)
    M(I(k),J(k),:)=cSnake;
end
[I,J]=list2sub(foodList);
for k=1:length(I)
    M(I(k),J(k),:)=cFood;
end
% ����Ŵ���Ⱦ
scale=round(scale);
im=imresize(M,scale,'nearest');
[m,n,~]=size(im);
indr=mod(1:m,scale)==0;
indc=mod(1:n,scale)==0;
im(indr,:,:)=0.85;
im(:,indc,:)=0.85;
im([1,end],:,:)=0;
im(:,[1,end],:)=0;
imshow(im);
title(sprintf('�÷�:%d',snakeList.size()-2));
end
%--------------------------------------------------------------------------
function [I,J] = list2sub(list)
% Java��List���double����
n=list.size();
x=zeros(n,2);
for i=1:n
    x(i,:)=list.get(i-1);
end
I=x(:,1);
J=x(:,2);
end

