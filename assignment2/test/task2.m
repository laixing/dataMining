clear;
clc;
close all;
data = importfile('overdoses.csv',2,51);
A = table;
A.population = data.Population;
A.deaths = data.Deaths;
A = zscore(table2array(A));

cosineSimilarity = zeros(50,50);
for i = 1:50
    for j = 1:50
        x = A(i,:);
        y = A(j,:);
        %temp1 = x(1,1)*y(1,1)+x(1,2)*y(1,2);
        cosineSimilarity(i,j) = dot(x,y)/sqrt(dot(x,x)*dot(y,y));
        %cosineSimilarity(i,j)=1 - pdist2(table2array(A(i,:)),table2array(A(j,:)),'cosine');  
    end
end
% output: similarity matrix
output = 'ResultTask2.csv';
fid = fopen(output, 'w');
for i = 1:50
    for j = 1:49
        fprintf(fid,['%s',','],num2str(cosineSimilarity(i,j)));
    end
    fprintf(fid,['%s','\n'],num2str(cosineSimilarity(i,50)));
end
fclose(fid);

%k-means clustering
[m,n] = size(cosineSimilarity);
%corresponding cluster number
B = zeros(m,1);
%number of clusters --> Objective function value.
C = zeros(14,2);

%Range of values of k (ranging from 2 to 15)
for k = 2:15
    %Initialize the cluster centers
    r = randperm(m);
    init = zeros(k,n);
    %init = A(r(1,1),1:n);
    for i = 1:k
        init(i,:) = cosineSimilarity(r(1,i),:);
    end
    
    % No further changes in the cluster centers in the next iteration
    % Maximum number of iterations:500
    flag = 1;
    count = 1;
    dist = zeros(1,k);
    while(flag == 1)
        for i = 1:m
            for j = 1:k
                dist(1,j) = sqrt(sum((cosineSimilarity(i,:) - init(j,:)) .^ 2));
            end
            [dr,dc] = find(dist == min(dist(1,:)));
            B(i,1) = dc;
        end
        
        %new center
        newCenter = zeros(k,n);        
        for j = 1:k
            numC = 0;
            sumC = zeros(1,n);
            for i = 1:m
                if B(i,:) == j
                    sumC(1,:) = sumC(1,:) + cosineSimilarity(i,:);
                    numC = numC + 1;
                end                
            end
            newCenter(j,:) = sumC / numC;
        end
        
        count = count + 1;
        if count > 500 || isequal(newCenter, init)
            flag = 0;
            % How to calculate J ?? what is m_i,j ??
            J = 0;
            for j = 1:k
                for i = 1:m
                    if B(i,:) == j
                        J = J + sum((cosineSimilarity(i,:) - newCenter(j,:)) .^ 2);
                    end                    
                end
            end
            C(k-1,:) = [k,J];
        else
            init = newCenter;
        end
    end
end

%draw the k-J plot
plot(C(:,1),C(:,2));
title('Task 2');
xlabel('Number of clusters(k)');
ylabel('Objective function value(J)');
