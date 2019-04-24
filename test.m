close all
clear 
clc 

dir = fullDir(1,1);
file = [dir,sprintf('/EEG_%d.txt',1)];
data = importdata(file);

time = data(:,1);
EEG = data(:,2);
dt = time(2) - time(1);

%% Test for function 'PhaseSpace'

% [Xmat, tau, numD] = ReconstructPhaseSpace(EEG);
load('Xmat_PatientA.mat');
% load('Xmat_ControlA.mat');

% figure;
% plot3(Xmat(1,:),Xmat(2,:),Xmat(3,:))
% xlabel('1st axis')
% ylabel('2nd axis')
% zlabel('3rd axis')
% title(sprintf('Phase space: tau=%d, numD=%d',tau,numD))
% grid on

% %% Test for function 'NearestNeighbors'
% 
% radius=0.5;
% cntVec = [];
% for i=1:size(Xmat,2)-1
%     cnt = NearestNeighbors(Xmat,Xmat(:,i:i+1),radius);
%     cntVec = [cntVec cnt];
% end
% 
% figure;
% plot(cntVec)
% xlabel('Points in Phase space')
% ylabel('# of Recurrence')
% 
% %% Nonlinear measure: correlation dimension D2
% rVec=1:200:1000;
% 
% CVec = CorrelationDimension(Xmat, rVec);
% D2Vec = log(CVec)./log(rVec);
% 
% figure('Position', [0 0 300 300])
% plot(log(rVec), log(CVec))
% xlabel('log r')
% ylabel('log C(r)')
% title('correlation function')
% 
% figure('Position', [0 0 300 300])
% plot(log(rVec), D2Vec)
% xlabel('log r')
% ylabel('D2')
% title('D2')
% 
%% Nonlinear measure: largest lyapunov exponent 
% maxiter=size(Xmat,2)/50;
% [d lle neardis]= LyapunovExponent(Xmat, 2, maxiter, 1/dt, 1);
% % neardis
% figure('Position', [0 0 300 300])
% plot(1:maxiter, d);
% xlabel('iteration')
% ylabel('divergence')
% title('divergence of nearest trajectoires') 
% fprintf("largest lyapunov exponent %f", lle);

%% surrogate data generator 

[y, errorAmplitude, errorSpec, fourierCoeff, sortedValues] = SurrogateDataGenerator(EEG);
[Xmat, tau, numD] = ReconstructPhaseSpace(y);
save Xmat_PatientA_surrogate.mat

% figure('Position', [0 0 300 300])
% plot(real(y))
% title('Surrogate after amplitude adaptation')
% axis tight
% 
% figure('Position', [0 0 300 300])
% plot(EEG)
% title('original')


%% Recurrence plot
% [RMat, cnt] = Recurrence(Xmat);
% figure('Position',[0 0 300 300])
% scatter(RMat);

