clc
clear all
close all
trainingSet='PB1_train.csv';
T=importdata(trainingSet);
X=T(:,1:3);
Y=T(:,4);
%%for linear kernel SVM
Mdl = fitcsvm(X,Y,'KernelFunction','linear','Standardize',true);
testingSet='PB1_test.csv';
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
fprintf('The predicted value of linear kernel SVM for the test data are\n'); disp(label');
fprintf('The percentage of accuracy for linear kernel SVM is %f\n', accuracy);

%%for polynomial kernel SVM
Mdl1=fitcsvm(X,Y,'KernelFunction','polynomial','PolynomialOrder',5,'Standardize',false);
label1 = predict(Mdl1,X1);
total1=0;
for i=1:m
    if T1(i,4)==label1(i,1)
        total1=total1+1;
    end
end
accuracy1=total1/m;
fprintf('The predicted value of polynomial kernel SVM for the test data are\n'); disp(label1');
fprintf('The percentage of accuracy for polynomial kernel SVM is %f\n', accuracy1);

%%for radial basis function kernel
Mdl2=fitcsvm(X,Y,'KernelFunction','rbf','Standardize',false);
label2 = predict(Mdl2,X1);
total2=0;
for i=1:m
    if T1(i,4)==label2(i,1)
        total2=total2+1;
    end
end
accuracy2=total2/m;
fprintf('The predicted value of radial basis function kernel SVM for the test data are\n'); disp(label2');
fprintf('The percentage of accuracy for radial basis function kernel SVM is %f\n', accuracy2);
