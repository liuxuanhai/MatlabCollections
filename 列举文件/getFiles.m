function fs = getFiles(path,reg)
% ��ȡ�ļ����������ļ�
% �����ܹ�ͨ��������ʽ���й���
if nargin<2
    reg='';
end
fs=dir(path);
fs=arrayfun(@(f){fullfile(path,f.name)},fs(3:end));
if ~isempty(reg)
    ind=cellfun(@(c)~isempty(regexp(c,reg,'once')),fs);
    fs=fs(ind);
end
end
