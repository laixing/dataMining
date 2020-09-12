filename='overdoses.csv';
T=readtable(filename);
A=table2array(T);
X=table2array(T(:,2));
Y=table2array(T(:,3));
X=str2double(X);
Y=str2double(Y);
R=corrcoef(X,Y);
ODD=Y./X;
bar(ODD);
title('Opioid Death Density of different states');
xlabel('states');
ylabel('Density');
states=table2array(T(:,4));
max=0;
for num=1:1:50
    for num1=1:1:50
        diff=abs(ODD(num)-ODD(num1));
        if(diff>max)
            max=diff;
        end
    end 
end
nrows=51;
ncols=51;
C=cell(51,51);
C{1,1}='ODD similarity';
for i=1:1:50
    C{1,1+i}=states(i);
    C{1+i,1}=states(i);
end
for num=1:1:50
    for num1=1:1:50
        diff=abs(ODD(num)-ODD(num1));
        if(diff==0)
            C{num+1,num1+1}=1;
            C{num1+1,num+1}=1;
        elseif(diff==max)
            C{num+1,num1+1}=0;
            C{num1+1,num+1}=0;
        else
            C{num+1,num1+1}=1-diff/max;
            C{num1+1,num+1}=1-diff/max;
        end
    end
end











