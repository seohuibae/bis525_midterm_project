%% correlation dimension across different embedding dimension

% clear 
% clc
% dir = fullDir(1,1);
% file = [dir,sprintf('/EEG_%d.txt',1)];
% data = importdata(file);
% time = data(:,1);
% EEG = data(:,2);
% dt = time(2) - time(1);
% 
% tauMax = 3000;
% tauVec = 100:100:tauMax;
% AMIVec = [];
% for tau=tauVec
%     AMI = AverageMutualInformation(EEG,tau);
%     AMIVec = [AMIVec AMI];
% end
% 
% [~,i]= min(AMIVec);
% tau_opt = tauVec(i);
% 
% result=[];
% dimspace=1:7;
% for dim=dimspace
%     Xmat = PhaseSpace(EEG,tau_opt,dim);
%     rVec=0:100:1900;
%     CVec = CorrelationDimension(Xmat, rVec);
%     slopeVec=zeros(1,length(rVec)-5);
%     for ii=1:length(rVec)-5
%         dx=log(rVec(ii+5))-log(rVec(ii));
%         dy=log(CVec(ii+5))-log(CVec(ii));
%         slope=dy./dx;
%         slopeVec(ii)=slope;
%     end
%     D2=nanmax(slopeVec);
% %     D2Vec = log(CVec)./log(rVec);
% %     D2 = nanmax(D2Vec);
%     result = [result D2];
% end

% load('D2_varyingED.mat')
load('D2_varyingED_2.mat')
figure('Position',[0 0 300 300])
scatter(dimspace, result, 'filled','k')
ylim([0 0.2])
xlim([0 7])
xlabel('embedding dimension')
ylabel('D2')
