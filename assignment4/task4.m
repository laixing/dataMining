clc
clear all
close all
trainingSet='PB4_train.csv';
T=importdata(trainingSet);
X=T(:,1:3);
Y=T(:,4);
Mdl = fitctree(X,Y);
view(Mdl,'Mode','graph');
testingSet='PB4_test.csv';
T2=importdata(testingSet);
X1=T2(:,1:3);
label = predict(Mdl,X1);
[m,n] = size(T2);
total=0;
for i=1:m
    if T2(i,4)==label(i,1)
        total=total+1;
    end
end
accuracy=total/m;

    
    