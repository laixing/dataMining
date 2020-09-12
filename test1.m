clc
clear all
close all
filename='Dataset_3.csv';
T=readtable(filename);
A=table2array(T);
k=2;
CV = '+r+b+c+m+k+yorobocomokoysrsbscsmsksy';
clf
data = A(:,1:2);
sigma = 1;
K=3;
label = minimax_diameter(data,2);