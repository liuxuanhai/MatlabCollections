function s = mexGetMD5(fname)
if ~ischar(fname)
    error('���������ļ���');
end
if ~exist(fname,'file')
    error('�ļ�������: %s',fname);
end
s=sprintf('%02X',md5(fname));
end