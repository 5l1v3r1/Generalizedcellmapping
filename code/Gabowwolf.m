function [temp,mid,Order,Part,Path,Root]=Gabowwolf(CMQ,m,v,temp,mid,Order,Part,Path,Root)
Order(v)=temp;
temp=temp+1;
Path=[Path;v];
Root=[Root;v];

[next,~]=find(CMQ(v,:)'==1);
if isempty(next)==0
    [n,~]=size(next);
    for i=1:n
        if Order(next(i))==-1
            [temp,mid,Order,Part,Path,Root]=Gabowwolf(CMQ,m,next(i),temp,mid,Order,Part,Path,Root);%%�ڴ�ʹ���˵ݹ�
        else
            if Part(next(i))==-1
                while Order(Root(end))>Order(next(i))
                    Root(end)=[];
                end
            end
        end
    end
end

if v==Root(end)
    Root(end)=[];
    mid=mid+1;
    while 1
        Top=Path(end);
        Part(Top)=mid;
        Path(end)=[];
        if Top==v
            break
        end
    end
end

%{
author:GNN
gabow�㷨
����˵����
����1��
�����ж����У���һ��û�б����ʹ��ý��v����vΪ����ִ�в���2��������ɡ�
����2��
��¼v�ķ���˳��Order����
��vѹ���ջPath��Root��
���vָ���������ڽӶ��㣬��ô����ÿ���ڽӶ���next��
1�����û�з��ʹ�������nextΪ�������ݹ�ִ�в���2.
2��������ʹ�������û��ȷ���������ĸ�ǿ��ͨ����������Rootջ��next֮�����еĶ��㡣
���Rootջ�Ķ�Ԫ�ص���v����ô��Part�м�¼�����Ӧ��ǿ��ͨ������
���ݹ鷵�ء�
%}
