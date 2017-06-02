function xls_merge_write(fname,x,rs,cs)
% ����cell��Excel���ϲ���Ԫ��
% ���룺
%   fname   �����ļ���
%   x       ��������ݣ�������cell
%   rs      ��Ҫ�ϲ�����
%   cs      ��Ҫ�ϲ�����
% �ϲ�����
%   1. �Ȱ��кϲ�����ָ�����ڣ�cell=[]��NaN��������ϲ�
%   2. �ڰ��кϲ�����ָ�����ڣ�cell=[]��NaN�������Ϻϲ�
%   +. ��ôд���ܺϲ�һ�������
e=actxserver('Excel.Application');% Excel
w=e.Workbooks.Add;% Workbook
s=get(e.ActiveWorkbook.Sheets,'Item',1);% Sheet
[m,n]=size(x);
[startCell,stopCell]=getRange(s,1,1,m,n);
r=get(s,'Range',startCell,stopCell);
r.Value=x;
arrayfun(@(r)merge_row(s,r,x(r,:)),rs);
arrayfun(@(c)merge_col(s,c,x(:,c)),cs);
path=abspath(fname);
if exist(path,'file')
    delete(path);
end
SaveAs(w,path);
Close(w);
Quit(e);
delete(e);
end
%--------------------------------------------------------------------------
function [S,E]=getRange(s,i1,j1,i2,j2)
S=get(s.Cells,'Item',i1,j1);
E=get(s.Cells,'Item',i2,j2);
end
%--------------------------------------------------------------------------
function merge_col(s,col,data)
n=length(data);
data=data(:);
id=cellfun(@(x)~isempty(x)&&any(~isnan(x)),data);
st=[find(id);n+1];
m=length(st)-1;
for k=1:m
    if st(k+1)-st(k)>1
        [S,E]=getRange(s,st(k),col,st(k+1)-1,col);
        r=get(s,'Range',S,E);
        r.MergeCells=1;
    end
end
end
%--------------------------------------------------------------------------
function merge_row(s,row,data)
n=length(data);
data=data(:);
id=cellfun(@(x)~isempty(x)&&any(~isnan(x)),data);
st=[find(id);n+1];
m=length(st)-1;
for k=1:m
    if st(k+1)-st(k)>1
        [S,E]=getRange(s,row,st(k),row,st(k+1)-1);
        r=get(s,'Range',S,E);
        r.MergeCells=1;
    end
end
end
%--------------------------------------------------------------------------
function [absolutepath]=abspath(partialpath)
% parse partial path into path parts
[pathname, filename, ext] = fileparts(partialpath);
% no path qualification is present in partial path; assume parent is pwd, except
% when path string starts with '~' or is identical to '~'.
if isempty(pathname) && partialpath(1) ~= '~'
    Directory = pwd;
elseif isempty(regexp(partialpath,'^(.:|\\\\|/|~)','once'));
    % path did not start with any of drive name, UNC path or '~'.
    Directory = [pwd,filesep,pathname];
else
    % path content present in partial path; assume relative to current directory,
    % or absolute.
    Directory = pathname;
end
% construct absolute filename
absolutepath = fullfile(Directory,[filename,ext]);
end