function s = getMD5(fname)
if ~ischar(fname)
    error('���������ļ���');
end
if ~exist(fname,'file')
    error('�ļ�������: %s',fname);
end
s=char(ecnu.yjt.MessageDigestFuncs.md5(fname));
end