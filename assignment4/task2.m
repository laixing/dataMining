clc
clear all
close all
trainingSet='PB2_train.csv';
T=importdata(trainingSet);
X=T(:,1:2);
Y=T(:,3);
mdl = fitlm(X,Y);
theta=mdl.Coefficients.Estimate;
theta0=theta(1,1);
theta1=theta(2,1);
theta2=theta(3,1);
testingSet='PB2_test.csv';
T2=importdata(testingSet);
T2(:,4)=theta0+theta1*T2(:,1)+theta2*T2(:,2);
T2(:,5)=(T2(:,4)-T2(:,3)).^2;
MSE=mean(T2(:,5),1);
y_value=theta0+theta1*19+theta2*76;
figure(2);
scatter3(T2(:,1),T2(:,2),T2(:,3),'r');
hold on;
[X1,X2]=meshgrid(T2(:,1),T2(:,2));
Y1=theta0+theta1*X1+theta2*X2;
surf(X1,X2,Y1);
hold off
grid on 
savefig('figure2.fig');
view([0 0]);
savefig('figure2_1.fig');


