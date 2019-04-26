
clear; close all;

dir = fullDir(1,1);
file = [dir,sprintf('/EEG_%d.txt',1)];
data = importdata(file);

time = data(:,1);
x = data(:,2);


[Xmat,tau_opt,numDim] = ReconstructPhaseSpace(x);

fprintf('Number of dimension: %d\n',numDim);
fprintf('Optimal time delay : %d\n',tau_opt);

figure;
plot3(Xmat(1,:),Xmat(2,:),Xmat(3,:))
xlabel('1st axis')
ylabel('2nd axis')
zlabel('3rd axis')
title(sprintf('Phase space: tau=%d',tau_opt))
grid on
