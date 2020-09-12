clc
clear all
close all
filename='overdoses.csv';
T=readtable(filename);
A=table2array(T);
X=table2array(T(:,2));
Y=table2array(T(:,3));
X=str2double(X);
Y=str2double(Y);
C=[X(:),Y(:)];
ODD=Y./X;
cosinesim=zeros(50,50);
for i=1:50
    for j=1:50
        cosinesim(i,j)=getCosineSimilarity(C(i,:),C(j,:));
    end
end
        
        