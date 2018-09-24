function res = cellsql(data,cols,type,sql,tbnm)
% �� cell ������ִ�� sql ��ѯ���
% ����:
%     data  2ά cell ����
%     cols  ��������
%     type  ��������, c=text d=double 
%     sql   sql ���
%     tbnm  ��ʱ����
% ���:
%     res ��ѯ���
% ע��:
%     double ��֧�� NaN �� []
dbfile=sprintf('tmp%f.db',rand());
conn=sqlite(dbfile,'create');
tmap=containers.Map({'c','d'},{'text','double'});
dbct=[cols(:)';arrayfun(@(c){tmap(c)},type)];
dbct=sprintf('%s %s,',dbct{:});
dbct=sprintf('create table %s( %s );',tbnm,dbct(1:(end-1)));
exec(conn,dbct);
insert(conn,tbnm,cols,data);
res=fetch(conn,sql);
close(conn);
delete(dbfile);
end