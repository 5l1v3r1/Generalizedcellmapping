function columnmatrix=FCMP(column,group,cgrouping,grouping)
%author��GNN
%input:����ѹ����ĵڶ����㼯�͵������㼯
%output:���δѹ��ǰ�ĵڶ��������㼯
%Notes:�����Ҫ���δѹ��ǰ�ĵ�һ�ڶ��������㼯��ת��6�У�[temp1,~]=find(cgrouping<0);��
[temp1,~]=find(cgrouping<0);%����ѵ�һ���㼯ӳ���ԭ���,��Ҫ��<����~=
[~,ib,ia]=intersect(column,temp1);
if isempty(ib)==0
    [n,~]=size(ib);
    column(ib)=[];
    mid=[];
    for i=1:n
        [mid1,~]=find(group==cgrouping(temp1(ia(i))));
        mid=[mid;mid1];
    end
    column=grouping(column);
    mid=[column;mid];
    columnmatrix=unique(mid);
else
    columnmatrix=grouping(column);
end
end