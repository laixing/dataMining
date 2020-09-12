import matplotlib.pyplot as plt
import numpy as np
import math
import operator


def euclidean_distance(instance1,instance2):
    return math.sqrt(np.sum(np.square(instance1 - instance2)))

def get_neighbours(trainingData,training_labels,testSample,k):
    distances = []
    neighbours = []
    for index,trainingInstance in enumerate(trainingData):
        dist = euclidean_distance(trainingInstance,testSample)
        distances.append((training_labels[index],dist))
    distances.sort(key=operator.itemgetter(1))
    for i in range(k):
        neighbours.append(distances[i][0])
    return neighbours

def get_most_occuring_label(neighbours):
    votes = {}
    for neighbour in neighbours:
        if neighbour in votes:
            votes[neighbour] +=1
        else:
            votes[neighbour] =1
    votes = sorted(votes.iteritems(), key=operator.itemgetter(1), reverse=True)
    return votes[0][0]

def label_list(filename):
    fileObj = open(filename,'rb')
    dataRead = fileObj.read()
    dataReadFromB16 = dataRead[8:]
    labels = np.frombuffer(dataReadFromB16, dtype=np.ubyte)
    return labels

def data_sorting(filename,size):
    fileObj2 = open(filename, "rb")
    dataRead = fileObj2.read()
    dataReadFromB16 = dataRead[16:]
    image1DArray = np.frombuffer(dataReadFromB16, dtype=np.ubyte)
    matrix_2 = image1DArray.reshape((size * 28, 28))
    matrix_3 = matrix_2.reshape((size, 28, 28))
    matrix_3 = matrix_3 / 255.0
    return matrix_3


if __name__ == "__main__":


    train_x_file = "./train-images.idx3-ubyte"
    train_matrix= data_sorting(train_x_file, 60000)
    train_matrix1=train_matrix[:6000,:,:]
    print (train_matrix1.shape)

    train_y_file = "./train-labels.idx1-ubyte"
    train_label = label_list(train_y_file)
    train_label1=train_label[:6000]
    print(train_label1.shape)

    train_x_file = "./t10k-images.idx3-ubyte"
    test_matrix = data_sorting(train_x_file,10000)
    test_matrix1=test_matrix[:1000,:,:]
    print(test_matrix1.shape)

    train_y_file = "./t10k-labels.idx1-ubyte"
    test_label = label_list(train_y_file)
    test_label1=test_label[:1000]
    print(test_label1.shape)

    k_values = [1, 9, 19, 29, 39, 49, 59, 69, 79, 89, 99]
    # sum_error_rate = [0.0]*len(k_values)
    # for i in range(5):
    error_rate = [0.0]*len(k_values)
    for ind,k in enumerate(k_values):
        print ("For K: "+str(k))

        total_count = len(test_matrix1)
        correct_count = 0
        for x in range(len(test_matrix1)):
            neighbors = get_neighbours(train_matrix1, train_label1, test_matrix1[x], k)
            result = get_most_occuring_label(neighbors)
            print (x)
            print('> predicted=' + repr(result) +', actual=' + repr(test_label1[x]))
            if result == test_label1[x]:
                correct_count +=1
        error_rate[ind] =1.0-float(correct_count)/total_count
    print (k_values)
    print (error_rate)
    #sum_error_rate+= error_rate

    # sum_error_rate2 = [0.0]*len(k_values)
    # for i in range(5):
    error_rate2 = [0.0]*len(k_values)
    for ind2,k2 in enumerate(k_values):
        print ("For K: "+str(k2))

        total_count2 = len(train_matrix1)
        correct_count2 = 0
        for x2 in range(len(train_matrix1)):
            neighbors2 = get_neighbours(train_matrix1, train_label1, train_matrix1[x2], k2)
            result2 = get_most_occuring_label(neighbors2)
            print (x2)
            print('> predicted=' + repr(result2) +', actual=' + repr(train_label1[x2]))
            if result2 == train_label1[x2]:
                correct_count2 +=1
        error_rate2[ind2] =1.0-float(correct_count2)/total_count2
    print (k_values)
    print (error_rate2)
    # sum_error_rate2+= error_rate2
    # error_rate1 = sum_error_rate1 / 5
    # error_rate2 = sum_error_rate2 / 5

    plt.plot(k_values, error_rate, 'go-', label='test error')
    plt.plot(k_values, error_rate2, 'yo-', label='training error')
    plt.ylabel('error rate')
    plt.xlabel('k values')
    plt.legend()
    plt.savefig('./KNN.png')
    plt.show()
