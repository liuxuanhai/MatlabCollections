function res = query_cells(conn,varargin)
% ��������Ϊ data type tbnm ���ظ�, ���һ�������� sql
if mod(length(varargin)-1,3)~=0
    error('invalid input parameters.');
end
insert_cells(conn,varargin{1:(end-1)});
sql=varargin{end};
sqls=strsplit(sql,';');
sqls(cellfun(@(s)isempty(strtrim(s)),sqls))=[];
for k=1:(length(sqls)-1)
    exec(conn,sqls{k});
end
res=fetch(conn,sqls{end});
end