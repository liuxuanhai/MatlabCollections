clc,clear,close all;

% ��������
inFile='1.jpg';         % ����ͼƬ
outFile='r1.jpg';       % ���ͼƬ
inPath='./lib';         % ͼƬ��
numGrids=70;            % ���񻮷�����Խ����ͼƬԽ��ϸ����������ͼƬҲ����
minBlockWidth=16;       % ƴͼʱ�ķֿ��С��ԽС�ٶ�Խ��
minRebuildWidth=128;    % �ؽ�ʱ�ķֿ��С��Խ�����ɵ��ļ�Խ��
usageRate=1/2.5;        % ͼƬ�����ʣ�Խ�ߣ����洿����Խ��
gifName='res.gif';      % �������ɹ���Ϊgif������Ϊ''�򲻱���
showPeriod=500;         % ���ɹ����У�ÿƴͼ�����ž���ʾһ��


st=tic;

% ͼƬ��Ϣ����
[im,blockSize,rebuildSize] = getParams(...
    inFile,numGrids,minBlockWidth,minRebuildWidth);

% �ڴ���Ϣ����
fs=getFiles(inPath);
numImgs=length(fs);
rebuildMem=prod(rebuildSize)*numGrids^2*3/1024^2;
imgMem=prod(rebuildSize)*3/1024^2*numImgs;
needMem=rebuildMem+imgMem;
[~,sys]=memory;
restMem=sys.PhysicalMemory.Available/1024^2;
fprintf('��Ҫ�ڴ�     \t%g M\n',needMem);
fprintf('ϵͳʣ���ڴ� \t%g M\n',restMem);
if needMem>restMem
    error(['�ڴ治�㣬�������numGrids�����߼�СminRebuildWidth,',...
        '��������minBlockWidth\n']);
end

% ׼��ͼƬ
fprintf('���ڶ�ȡͼƬ...\n');
tic;
fs=getFiles(inPath);
imgs=cellfun(@(f){myImresize(imread(f),rebuildSize)},fs);
toc;

% ɾ��ȫ0ͼƬ
fprintf('ɸѡͼƬ��...\n');
tic
ind=cellfun(@(x)all(x(:)==0),imgs);
imgs(ind)=[];
toc

fprintf('��������ƴͼ����...\n');
tic;
mImgs=cellfun(@(x){im2double(imresize(x,blockSize))},imgs);
toc;

% ƴͼ
fprintf('����ƴͼ...\n');
tic
[IND,TS] = buildImg(im,mImgs,usageRate,gifName,showPeriod);
toc

% �ؽ�
res=rebuildImg(imgs,IND,TS,outFile);

f=dir(outFile);
fprintf('���ͼƬ��СΪ %.1f M\n',f.bytes/1024^2);


% �Ź�����ͼ�ϲ�
tic
fprintf('������ͼ...\n');
if ~exist('res','dir')
    mkdir('res');
end
[m,n,~]=size(res);
w=floor(min([m,n])/3);
for i=1:3
    for j=1:3
        rInd=(i-1)*w+(1:w);
        cInd=(j-1)*w+(1:w);
        s=res(rInd,cInd,:);
        imwrite(s,sprintf('./res/%d.jpg',(i-1)*3+j));
    end
end
toc

fprintf('�ܹ���ʱ %g ��\n',toc(st));
fprintf('����ͼƬ %d/%d\n',length(unique(IND(:))),length(imgs));
