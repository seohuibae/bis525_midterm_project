clear
clc
close all

ridx_fp=[[1,3,5];[2,4,6]];


pairs=[{'patient', 'control'},
    {'patient', 'patientSurrogate'},
    {'control', 'controlSurrogate'},
    {'patient','controlSurrogate'},
    {'control','patientSurrogate'},
    {'patientSurrogate', 'controlSurrogate'}];
%% embedding dimension
% 
T=readtable('./resulttable/EstED.csv');
% mat=table2array(T(:,pairs(1,:)));
% [p,tbl]=anova2(mat');

mat=table2array(T(:,3:end));
mu=mean(mat);
mu=reshape(mu,2,2);
figure('Position',[0 0 300 300])
hBar = bar(mu);
hBar(1).FaceColor='w';
hBar(2).FaceColor='k';
Labels = {'patient', 'control'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
colormap(gray)
ctr2 = bsxfun(@plus, hBar(1).XData, [hBar(1).XOffset]');
hold on
plot(ctr2(1:2), [1 1]*mu(1,2)*1.1, '-k', 'LineWidth',2)
plot(mean(ctr2(1:2)), mu(1,2)*1.15, '*k')

off=abs(hBar(1).XOffset);
plot([1-off, 1+off], [1 1]*mu(1,2)*1.05, '-k', 'LineWidth',2)
text(1-off/2, mu(1,2)*1.02, 'n.s.')

off=abs(hBar(2).XOffset);
plot([2-off, 2+off], [1 1]*mu(1,2)*1.05, '-k', 'LineWidth',2)
text(2-off/2, mu(1,2)*1.02, 'n.s.')
hold off
ylabel('Est-ED')


% boxplot(mat,'Notch','on','Labels',{'patient','control'})

%% D2 

% T=readtable('./resulttable/D2_temp.csv');
% mat=table2array(T(ridx_fp(1,:),pairs(6,:)));
% [p,tbl]=anova2(mat');

%% det,entr
% T=readtable('./resulttable/ENTR.csv');
% mat=table2array(T(ridx_fp(2,:),pairs(6,:)));
% 
% [p,tbl]=anova2(mat');
% % [h,p]=ttest(mat(:,1),mat(:,2)); 
% % p




