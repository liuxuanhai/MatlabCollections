function [im,blockSize,rebuildSize] = getParams(inFile,numGrids,minBlockWidth,minRebuildWidth)
% ��������
% �ֿ��С���ֺ�ͼƬ��С������ͬ�ı���
im=imread(inFile);
imSize=imsize(im);

blockSize=round(imSize*(minBlockWidth/min(imSize)));
imSize=blockSize*numGrids;
im=imresize(im,imSize);

rebuildSize=round(blockSize*(minRebuildWidth/min(blockSize)));
end
%--------------------------------------------------------------------------
function sz = imsize(im)
sz=size(im);
sz=sz(1:2);
end