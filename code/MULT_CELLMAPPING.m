%%
clear;clc;format long
bcell=[9 9 9];%���
smcell=[1 1 1];%С��
interval=[-0.15 0.35 -1 1 -0.01 1.8]';%%[x1min x1max x2min x2max x3min x3max]
MC=2;%���ؿ���ģ�����
t=0;%ʱ��t
D=0.1;%����ǿ��
h=0.1;%����
OSS=2;%һ��ӳ�䲽��
MQ=OSS/h;%ָ���Ǽ���һ��ӳ��ʱ����Ҫ�ļ�����
MemorySize=1e+8;%ָ����CPU��GPU�ڴ��С�����������̫��������Էֿ���У���ͬ���Դ�ֵ��ͬ
%% 
[cellnum,smcellnum,widght,CMQmat,CMQ]=GNN(bcell,smcell,interval,MC,MQ,MemorySize,t,D,h,OSS,"SDE");
%%
%��������㷨ģ�顪����������
P=MATANA(CMQmat,-100);%P=MATANA(CMQmat,-n,[����Ȥ�İ��ı��])    ����ȡΪ���ȷֲ���Ҳ����ȡΪ������ĳЩ���ķֲ�

%ֻ�����һά�Ļ�ͼ�������޸ģ���GRA���޸ļ���
GRA(P,bcell,interval,widght,-1);%��ģ��Ϊ��������㷨 ��MATANA��GRA��ͬ����

%%
%ͼ�����㷨ģ�顪�����Է���
[Order,Part]=Gabow(CMQ);
[CMPCMQ,group,cgrouping,grouping,ID]=CMP(CMQ,Part);
TSTDTY=GSLY(CMPCMQ,cgrouping);
time=datevec(datestr(now));
eval(['save(''F:\code\GNN\cache\V_',num2str(length(bcell)),'_',num2str(bcell(1)),'_',num2str(smcell(1)),'_',num2str(time(1)),'_',num2str(time(2)),'_',num2str(time(3)),'_',num2str(time(4)),'_',num2str(time(5)),'PP.mat'',''Part'',''CMPCMQ'',''group'',''grouping'',''TSTDTY'');']);
[FIR,SEC,D,trapD,D1,D2,SM,UM]=matly(TSTDTY,group,cgrouping,grouping);
%ͼ�����㷨��ͼ��Ŀǰֻ�ж�ά����ά�Ļ�ͼ�������޸ģ�����NEWplot���޸�
NEWplot(FIR,SEC,D,trapD,D1,D2,SM,UM,interval,widght,bcell,cellnum);
saveas(gcf, ['C:/Users/admin/Desktop/picture' num2str(length(bcell)) '_' num2str(bcell(1)) '_' num2str(smcell(1)) '_' num2str(time(1)) '_' num2str(time(2)) '_' num2str(time(3)) '_' num2str(time(4)) '_' num2str(time(5)) '.fig']);
saveas(gcf, ['C:/Users/admin/Desktop/picture' num2str(length(bcell)) '_' num2str(bcell(1)) '_' num2str(smcell(1)) '_' num2str(time(1)) '_' num2str(time(2)) '_' num2str(time(3)) '_' num2str(time(4)) '_' num2str(time(5)) '.jpg']);
MailAddress = '707288044@qq.com';
password = 'hvybqbpqjmygbfic';  
subject = '�������ѳ�';
content = '�����Ѿ������ˣ�';
MailServer='smtp.qq.com';
eval(['DataPath={''C:\Users\admin\Desktop\picture',num2str(length(bcell)),'_',num2str(bcell(1)),'_',num2str(smcell(1)),'_',num2str(time(1)),'_',num2str(time(2)),'_',num2str(time(3)),'_',num2str(time(4)),'_',num2str(time(5)),'.jpg''};';])
mailTome(MailAddress,password,subject,content,MailServer,DataPath);
datevec(datestr(now))


%%
%��Ҫ�޸Ķ�Ӧ��tode,CPU�汾ֻ��Ҫ�޸�V_tode���ɣ�GPU�汾û�н������ϣ�ȷ����ϵͳ�޸�V1_GPU_tode�����ϵͳ�޸�V2_GPU_tode
%�����Ĳ���Ҫ�޸ģ�ֻ��Ҫ�ڴ˽�������޸ļ���

%% 
%������Ͳ���
% MQ������Ҫ�����Ĵ���Խ�࣬MQԽ�󣬵������ֵû�п���ά������ά���ܲ�����
%OSSָ����0:h:OSS,���ϵͳ��ӳ�䲽�����ǵ�������������ϵͳ��ӳ�䲽������ѡȡ������ʱ�䣬��ͬϵͳֵ��ͬ���Է�����ϵͳ���ԣ�����ϵͳ��ӳ�䲽��һ��ȡ���ڣ�������ϵͳ�����������
%cellnumָ���ǲ������ݰ��İ���������smcellnumָ����һ������а�����С����������widghtָ���Ǵ��С���ĳߴ磬CMQmatָ����һ��ת�Ƹ��ʾ���CMQָ����һ��ת�Ƹ��ʾ����Ӧ��0-1����
% CMPCMQָ����ѹ�����һ��ת�Ƹ��ʾ���groupָ�������а��ķ��࣬cgrouping��grouping���ƣ�TSTDTYָ�������յİ��Ĺ���
%FIRָ���������ӣ�SECָ���ǰ���Dָ����ÿ����ǿ��ͨ������������trapDָ�����ݰ�������D1ָ���Ǳ�ǿ��ͨ�������������������������ӵ������򣩲������ݰ��������򣬵��������еı߽�
%D2ָ���Ǳ�ǿ��ͨ�������������������������ӵ������򣩣�������������ı߽磬SMָ�����ȶ����Σ�UMָ���ǲ��ȶ�����
% [cellnum,smcellnum,widght,CMQmat,CMQ,CMPCMQ]=GNN(bcell,smcell,interval,MC,MQ,MemorySize,t,D,h,OSS,"ODE" "SDE" "GPU" "MEMORY");
%Pָ����n������֮��ϵͳ��״̬�ռ�ĸ��ʷֲ�