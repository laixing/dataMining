clc
clear all
close all
trainingSet='PB2_train.csv';
T=importdata(trainingSet);
X=T(:,1:3);
Y=T(:,4);
Mdl = fitcnb(X,Y);
testingSet='PB2_test.csv';
T1=importdata(testingSet);
X1=T1(:,1:3);
label = predict(Mdl,X1);
Y1=T1(:,4);
[m,n] = size(T1);
total=0;
for i=1:m
    if T1(i,4)==label(i,1)
        total=total+1;
    end
end
accuracy=total/m;
fprintf('The predicted value for the test data are\n'); disp(label');
fprintf('The percentage of accuracy is %f\n', accuracy);