clear
clc
close all

T=readtable('EstED.csv');
mat=table2array(T(:,{'patient', 'control'}));
[p,tbl]=anova2(mat');
