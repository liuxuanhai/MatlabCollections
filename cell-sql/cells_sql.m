function res = cells_sql(varargin)
% ����Ϊ data type tbnm ���ظ�, ���һ�������� sql
dbfile=sprintf('tmp%f.db',rand());
setdbprefs('DataReturnFormat','cellarray');
setdbprefs('NullNumberRead','NaN');
setdbprefs('NullNumberWrite','NaN');
setdbprefs('NullStringRead','');
setdbprefs('NullStringWrite','');
conn=database('','','','org.sqlite.JDBC',sprintf('jdbc:sqlite:%s',dbfile));
res=query_cells(conn,varargin{:});
close(conn);
% delete(dbfile);
end