function mymex(fname)
% �� Visual Stdio �� C++ ��Ŀ���б���
% ���룺
%   fname C++�ļ���·��
% Լ�������ļ���Ϊ path/fcn.cpp
%   1. ����Ľ������Ϊ fcn
%   2. �������� stdafx.h ������
%   3. ����ԭ��Ϊ void fcn(int nlhs,mxArray* plhs[],int nrhs,mxArray* prhs[])
%   4. ��Ŀ�в����� __mexForCompile.cpp
[path,fcn,~]=fileparts(fname);
fprintf('���ڱ��� %s ...\n',fname);
opath=cd;
cd(path);
fname='__mexForCompile.cpp';
temp='#include"stdafx.h"\nvoid mexFunction(int nlhs,mxArray* plhs[],int nrhs,mxArray* prhs[]){%s(nlhs,plhs,nrhs,prhs);}';
fid=fopen(fname,'w');
fprintf(fid,temp,fcn);
fclose(fid);
fs=dir();
fs=arrayfun(@(s){s.name},fs(3:end));
isCpp=cellfun(@(s)~isempty(regexp(s,'.*\.cpp','once')),fs);
fs=fs(isCpp);
mex('-output',fcn,fs{:});
delete(fname);
mexName=[fcn,'.',mexext()];
clear(fcn);
movefile(mexName,fullfile(opath,mexName),'f');
cd(opath);
end

