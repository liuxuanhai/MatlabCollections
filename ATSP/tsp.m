function [x,f,optDist] = tsp(d)
% һ��TSP����㷨
% ���룺
%   d �������
% �����
%   x ���Ž�
%   f ���ź���ֵ
%   optDist=0 ��ʾ�ﵽ��ȫ�����Ž�
%
% ����ģ��Сʱ��������ٷ����
% ��ģ�ϴ�ʱ������intlinprog������⣬����ǷǶԳ�TSP���⣬��ת��Ϊ�Գ�TSP����������
n=length(d);
if n==0
    x=[];
    f=0;
    optDist=0;
elseif n==1
    x=1;
    f=d;
    optDist=0;
elseif n<=10
    [x,f]=mexTsp(d);
else
    if(any(any(d-d')))
        [x,f,optDist]=atsp(d);
    else
        [x,f,optDist]=intlinprogTsp(d);
    end
end
end
%--------------------------------------------------------------------------
function [x,v,optDist] = atsp(d)
% ���ǶԳ�TSP����ת��Ϊ�Գ�TSP����������
n=length(d);
M=sum(d(:));
MM=n^2*M;
d=d+diag(-M*ones(n,1));
U=MM*ones(n,n);
D=[U,d';
    d,U];
D=D-diag(diag(D));
[x,v,optDist] = intlinprogTsp(D);
x(x>n)=[];
v=v+n*M;
end
%--------------------------------------------------------------------------
function [xopt,costopt,optDist] = intlinprogTsp(dist)
% TSP��������㷨
% �ı���Matlab�Դ�TSP Example������Matlab intlinprog����.
% ���룺
%   dist �����ľ������
% �����
%   xopt ���Ž����˳���±�����
%   costopt ���ź���ֵ
%   optDist=0 ��ʾ�õ���ȫ�����Ž�
nStops = length(dist);
dist = squareform(dist);
dist = dist(:);
idxs = nchoosek(1:nStops,2);
lendist = length(dist);
Aeq = spones(1:length(idxs));
beq = nStops;
Aeq = [Aeq;spalloc(nStops,length(idxs),nStops*(nStops-1))];
for ii = 1:nStops
    whichIdxs = (idxs == ii);
    whichIdxs = sparse(sum(whichIdxs,2));
    Aeq(ii+1,:) = whichIdxs';
end
beq = [beq; 2*ones(nStops,1)];
intcon = 1:lendist;
lb = zeros(lendist,1);
ub = ones(lendist,1);
opts = optimoptions('intlinprog','Display','off');
[xopt,costopt,~,output] = intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);
tours = detectSubtours(xopt,idxs);
numtours = length(tours);
A = spalloc(0,lendist,0);
b = [];
while numtours > 1
    b = [b;zeros(numtours,1)];
    A = [A;spalloc(numtours,lendist,nStops)];
    for ii = 1:numtours
        rowIdx = size(A,1)+1;
        subTourIdx = tours{ii};
        variations = nchoosek(1:length(subTourIdx),2);
        for jj = 1:length(variations)
            whichVar = (sum(idxs==subTourIdx(variations(jj,1)),2)) & ...
                (sum(idxs==subTourIdx(variations(jj,2)),2));
            A(rowIdx,whichVar) = 1;
        end
        b(rowIdx) = length(subTourIdx)-1;
    end
    [xopt,costopt,~,output] = intlinprog(dist,intcon,A,b,Aeq,beq,lb,ub,opts);
    tours = detectSubtours(xopt,idxs);
    numtours = length(tours);
end
xopt=xtrans(xopt);
optDist=output.constrviolation;
end
%--------------------------------------------------------------------------
function subTours = detectSubtours(x,idxs)
x = round(x);
r = find(x);
substuff = idxs(r,:);
unvisited = ones(length(r),1);
curr = 1;
startour = find(unvisited,1);
while ~isempty(startour)
    home = substuff(startour,1);
    nextpt = substuff(startour,2);
    visited = nextpt; unvisited(startour) = 0;
    while nextpt ~= home
        [srow,scol] = find(substuff == nextpt);
        trow = srow(srow ~= startour);
        scol = 3-scol(trow == srow);
        startour = trow;
        nextpt = substuff(startour,scol);
        visited = [visited,nextpt];
        unvisited(startour) = 0;
    end
    subTours{curr} = visited;
    curr = curr + 1;
    startour = find(unvisited,1);
end
end
%--------------------------------------------------------------------------
function x = xtrans(x)
x=squareform(x);
n=length(x);
v=false(1,n);
z=zeros(n,1);
k=1;
z(1)=1;
v(1)=true;
nxt=find(x(z(k),:)&~v,1);
for k=2:n
    z(k)=nxt;
    v(z(k))=true;
    nxt=find(x(z(k),:)&~v,1);
end
x=z;
end
