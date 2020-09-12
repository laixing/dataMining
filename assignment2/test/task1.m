clear;
clc;
close all;
data = importfile('overdoses.csv',2,51);
%Create a table by extracting the population and deaths columns
A = table;
A.population = data.Population;
A.deaths = data.Deaths;
% Z-score standardization
A = zscore(table2array(A)); 
%m row, n Column.
[m,n] = size(A);

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
        init(i,:) = A(r(1,i),:);
    end
    
    % No further changes in the cluster centers in the next iteration
    % Maximum number of iterations:500
    flag = 1;
    count = 1;
    dist = zeros(1,k);
    while(flag == 1)
        for i = 1:m
            for j = 1:k
                dist(1,j) = sqrt(sum((A(i,:) - init(j,:)) .^ 2));
                %dist(1,j) = sum((A(i,:) - init(j,:)) .^ 2);
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
                    sumC(1,:) = sumC(1,:) + A(i,:);
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
                        J = J + sum((A(i,:) - newCenter(j,:)) .^ 2);
                    end                    
                end
            end
            C(k-1,:) = [k,J];
        else
            init = newCenter;
        end
    end
    
    %output: row->clusterLable, if k=5
    if k == 5
        D = (1:50)';
        E = table;
        E.row = D;
        E.clusterLable = B;
        
        fileName = 'ResultTask1.csv';
        fid = fopen(fileName, 'w');
        %fprintf(fid,['%s',','],'Row');
        %fprintf(fid,['%s','\n'],'clusterLable');
        for i = 1:50
            fprintf(fid,['%s',','],num2str(E.row(i)));
            fprintf(fid,['%s','\n'],num2str(E.clusterLable(i)));
        end
        fclose(fid);
    end
end

%draw the k-J plot
plot(C(:,1),C(:,2));
title('Task 1');
xlabel('Number of clusters(k)');
ylabel('Objective function value(J)');
%set(gca,'xtick',1:1:50)
%set(gca,'XTickLabel',C(:,1));
%xlabel('number of clusters(k)');
%ylabel('Objective function value(J)');
%title('Task1');