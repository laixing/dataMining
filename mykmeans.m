function [label] = mykmeans(data, K)

%% initialize centroids - randomly picks
N=size(data,1);
d = size(data, 2);
rand_index=randperm(N);
centroids_index=rand_index(1:K);
centroids=data(centroids_index,:);

%% initialize label & distance_to_centroids
label = zeros(N, 1);
distance_to_centroids = zeros(K, 1);

%% Main Iteration 

for Iter = 1: 100
    %% find nearest centroids of each point, and save it's data in label
    for i = 1:N
        % calculate distance_to_centroids, which is distance between each points and centroids
        for j = 1:K
            distance_to_centroids(j, 1) = norm(data(i, :)-centroids(j, :));
        end
        % find min_distance_to_centroids and find it's index
        min_distance_to_centroids = min(distance_to_centroids);
        index_min = find(distance_to_centroids == min_distance_to_centroids, 1, 'first');
        label(i, 1) = index_min;
    end

    %% update centroids
    for i=1:K
        for q=1:d
            sum_of_data = 0;
            number_of_data = 0;
            for j=1:N
                if(label(j, 1) == i)
                    sum_of_data = sum_of_data + data(j, q);
                    number_of_data = number_of_data + 1;
                end
            end
            centroids(i, q) = sum_of_data / number_of_data;
        end
    end
end

end