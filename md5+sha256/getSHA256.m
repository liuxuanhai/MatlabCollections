function s = getSHA256(fname)
if ~ischar(fname)
    error('���������ļ���');
end
if ~exist(fname,'file')
    error('�ļ�������: %s',fname);
end
s=char(ecnu.yjt.MessageDigestFuncs.sha256(fname));
end