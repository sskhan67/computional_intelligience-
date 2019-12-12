function [X_shuffle,Y_shuffle] = shuffle_data(X,Y)
% Input : dataset X, Y
% Output: shuffled data set X,Y 
     
    dataset = [X,Y]; % combine dataset 
    row = randperm(size(dataset,1));
    dataset_tmp = dataset(row,:);
    X_shuffle = dataset_tmp(:,1:2);
    Y_shuffle = dataset_tmp(:,3);

end