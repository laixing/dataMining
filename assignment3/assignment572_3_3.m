clc
clear all
close all
filename='Dataset_3.csv';
T=readtable(filename);
A=table2array(T);
k=2;
CV = '+r+b+c+m+k+yorobocomokoysrsbscsmsksy';
clf
figure(1)
hold on
for i=0:k
    PT=A(A(:,3)==i,:);
    plot(PT(:,1),PT(:,2),CV(2*(i+1)-1:2*(i+1)),'LineWidth',0.5);
end
hold off
grid on
savefig('figure3_1.fig');
%close(figure(1));

C=A(:,1:2);
m=3;
cents=C(ceil(rand(m,1)*size(C,1)),:);
cents1=cents;
dal=zeros(size(C,1),m+2);
judge=1;
while judge
    for i=1:size(C,1)
        for j=1:m
            dal(i,j)=norm(C(i,:)-cents(j,:));
        end
        [Distance CN]=min(dal(i,1:m));
        dal(i,m+1)=CN;
        dal(i,m+2)=Distance;
    end
    
    for i=1:m
        B=(dal(:,m+1)==i);
        cents1(i,:)=mean(C(B,:));
    end
    if cents1==cents
        judge=0;
    else
        cents=cents1;
    end
end
%clf
figure(2)
hold on
for i=1:m
    PT1=C(dal(:,m+1)==i,:);
    plot(PT1(:,1),PT1(:,2),CV(2*i-1:2*i),'LineWidth',0.5);
    plot(cents(:,1),cents(:,2),'*m','LineWidth',3);
end
hold off
grid on
savefig('figure3_2.fig');
%close(figure(2));

C1=A(:,1:2);
cents_21=C(ceil(rand(1,1)*size(C1,1)),:);
max=0;
for i=1:size(C1,1)
    dal_2=norm(C1(i,:)-cents_21(1,:));
    if dal_2 > max
        max=dal_2;
        cents_22=C1(i,:);
    end
end
max1=0;
for i=1:size(C1,1)
    dal_31=norm(C1(i,:)-cents_21(1,:));
    dal_32=norm(C1(i,:)-cents_22(1,:));
    if dal_31>dal_32
        if dal_32>max1
            max1=dal_32;
            cents_23=C1(i,:);
        end
    else
        if dal_31>max1
            max1=dal_31;
            cents_23=C1(i,:);
        end
    end
end
    
dal_22=zeros(size(C1,1),m+2);
for i=1:size(C1,1)
    dal_22(i,1)=norm(C1(i,:)-cents_21);
    dal_22(i,2)=norm(C1(i,:)-cents_22);
    dal_22(i,3)=norm(C1(i,:)-cents_23);
    
    [Distance CN]=min(dal_22(i,1:m));
    dal_22(i,m+1)=CN;
    dal_22(i,m+2)=Distance;
end
%clf
figure(3)
hold on
for i=1:m
    PT2=C(dal_22(:,m+1)==i,:);
    plot(PT2(:,1),PT2(:,2),CV(2*i-1:2*i),'LineWidth',0.5);
    if i==1
        plot(cents_21(:,1),cents_21(:,2),'*m','LineWidth',3);
    elseif i==2
        plot(cents_22(:,1),cents_22(:,2),'*m','LineWidth',3);
    elseif i==3
        plot(cents_23(:,1),cents_23(:,2),'*m','LineWidth',3);
    end
end
hold off
grid on 
savefig('figure3_3.fig');
%close(figure(3));

data = A(:,1:2);
figure,plot(data(:,1), data(:,2),'r+'), title('Original Data Points'); grid on;shg
% calculate the affinity / similarity matrix
affinity = CalculateAffinity(data);
figure,imshow(affinity,[]), title('Affinity Matrix')

D=zeros(size(affinity,1),size(affinity,2));
for i=1:size(affinity,1)
    E=affinity(i,:);
    E=sort(E,'descend');
    D(i,i)=sum(E(1:6));
    
    %D(i,i) = sum(affinity(i,:));
end
% compute the normalized laplacian / affinity matrix (method 1)
%NL1 = D^(-1/2) .* L .* D^(-1/2);
for i=1:size(affinity,1)
    for j=1:size(affinity,2)
        NL1(i,j) = affinity(i,j) / (sqrt(D(i,i)) * sqrt(D(j,j)));  
    end
end

% perform the eigen value decomposition
[eigVectors,eigValues] = eig(NL1);
% select k largest eigen vectors
k = 3;
nEigVec = eigVectors(:,(size(eigVectors,1)-(k-1)): size(eigVectors,1));
 %construct the normalized matrix U from the obtained eigen vectors
for i=1:size(nEigVec,1)
    n = sqrt(sum(nEigVec(i,:).^2));    
    U(i,:) = nEigVec(i,:) ./ n; 
end
U=nEigVec;
% perform kmeans clustering on the matrix U
dal_3=zeros(size(U,1),k+2);
cents_3=U(ceil(rand(k,1)*size(U,1)),:);
cents_31=cents_3;
judge3=1;

while judge3
    for i=1:size(U,1)
        for j=1:k
            dal_3(i,j)=norm(U(i,:)-cents_3(j,:));
        end
        [Distance CN]=min(dal_3(i,1:k));
        dal_3(i,k+1)=CN;
        dal_3(i,k+2)=Distance;
    end
    for i=1:k
        B_3=(dal_3(:,k+1)==i);
        cents_31(i,:)=mean(U(B_3,:));
    end
    if cents_31==cents_3
        judge3=0;
    else
        cents_3=cents_31;
    end
end
figure(4)
hold on
for i=1:k
    PT3=data(dal_3(:,k+1)==i,:);
    plot(PT3(:,1),PT3(:,2),CV(2*i-1:2*i),'LineWidth',0.5);
end
hold off
title('Spectral clustering using K-means');
grid on
savefig('figure3_4.fig');

        

    
    

