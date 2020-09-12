function [label] = spectral_clust(data, K, sigma)

N = size(data, 1);

%% affinity matrix
matrix_A = zeros(N, N);
for i=1:N
    for j=1:N
        distance_ij = norm(data(i,:)-data(j,:));
        matrix_A(i, j) = exp(-distance_ij/(2*sigma^2));
        if(i == j)
            matrix_A(i, j) = 0;
        end
    end
end

select = zeros(N,N);
for i=1:N
    [~,index] = sort(matrix_A(i,:),'descend');
    top5_index=index(1:5);
    select(i,top5_index) = 1;
end
for i=1:N
    for j=1:N
        if select(i,j)==0 && select(j,i)==0
            matrix_A(i,j) = 0;
        end
    end
end   
%% matrix D
matrix_D = zeros(N, N);

for i=1:N
    matrix_D(i, i) = sum(matrix_A(i, :));
end
%% matrix L
% L = D^(-1/2) * A * D^(-1/2)
matrix_L = zeros(N, N);

for i=1:N
    for j=1:N
        matrix_L(i,j) = matrix_A(i,j) / (sqrt(matrix_D(i,i)) * sqrt(matrix_D(j,j)));  
    end
end

%% matrix X
[eigenvectors, ~] = eig(matrix_L);

matrix_X = zeros(N, K);
size_eigenvectors = size(eigenvectors(1,:));
size_eigen = size_eigenvectors(1,2);
matrix_X(:, :) = eigenvectors(:, size_eigen-K+1:size_eigen);

%% matrix Y
matrix_Y = normc(matrix_X);

%% cluster them using K-means algorithm
label = mykmeans(matrix_Y, K);

%% visualize result
visualize_result(data, label);


end