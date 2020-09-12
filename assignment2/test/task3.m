clear;
clc;
close all;
%book on data science
x1 = [2000 3000 2500 2000];
%book on soccer
x2 = [1500 2500 4000 3000];
%article on data science
x3 = [20 30 25 20];
%article on soccer
x4 = [15 25 40 30];

X = [x1; x2; x3; x4];

%Cosine similarity
cosineSimilarity = zeros(4,4);
A = [1:4;1:4]';
for i = 1:4
    for j = 1:4
        x = X(i,:);
        y = X(j,:);
        if i == j
            cosineSimilarity(i,j) = 0;
        else
            cosineSimilarity(i,j) = dot(x,y)/sqrt(dot(x,x)*dot(y,y));
        end      
    end
    [dr,dc] = find(cosineSimilarity(i,:) == max(cosineSimilarity(i,:)));
    A(i,2) = dc;
end
%Euclidean distance
Euclideandistance = zeros(4,4);
B = [1:4;1:4]';
for i = 1:4
    for j = 1:4
        x = X(i,:);
        y = X(j,:);
        if i == j
           Euclideandistance(i,j) = 10000;
        else
           Euclideandistance(i,j) = norm(x - y);
        end      
    end
    [dr2,dc2] = find(Euclideandistance(i,:) == min(Euclideandistance(i,:)));
    B(i,2) = dc2;
end
