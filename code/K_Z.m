function SE=K_Z(C_SE,bcell)%SEΪһ������C_SEΪһ�������������
m=length(bcell);
temp=1;
SE=C_SE(:,1);
for i=2:m
    temp=temp*bcell(i-1);
    SE=SE+(C_SE(:,i)-1)*temp;
end