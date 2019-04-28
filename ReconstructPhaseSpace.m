%% Main function
function [Xmat,tau_opt,numDim, tauVec,FNN, AMIVec, dimVec] = ReconstructPhaseSpace(x)
% Finding optimal delay
tauMax = 3000;
tauVec = 100:100:tauMax;

AMIVec = [];
for tau=tauVec
    AMI = AverageMutualInformation(x,tau);
    AMIVec = [AMIVec AMI];
end

[~,i]= min(AMIVec);
tau_opt = tauVec(i);

% Finding estimated dimension
epsilon = 1;

dimMax = 10;
dimVec = 2:dimMax;

FNN = [];
for dim = dimVec
    FNN = [FNN,numFNN(x,tau_opt,dim,epsilon)];
end
numDim = dimVec(find(FNN==0,1));


% Reconstructed Phase space
Xmat = PhaseSpace(x,tau_opt,numDim);

end

%% Phase Space
function Xmat = PhaseSpace(x,tau,numD)
% ===== inputs =====
% x: 1D time series (in time domain)
% tau: delay
% numD: number of dimension

% ===== outputs =====
% Xmat: every points in phase space ( numD * num of points)

len = length(x);

Xmat = [];
for i = 1:len-(numD-1)*tau
    Xvec = x(i:tau:i+(numD-1)*tau); % A point in phase space
    Xmat = [Xmat Xvec];
end

end

%% Average Mutual Information
function AMI = AverageMutualInformation(x,tau)
% ===== input =====
% x: whole time series
% tau: delay

% ===== output =====
% AMI: Average mutual information

AMI=0;
len = length(x);
for i=1:len-tau
    MI = MutualInformation(x(i),x(i+tau),x);
    if ~isnan(MI); AMI = AMI + MI; end
end
AMI = AMI/(len-tau);
end


function MI = MutualInformation(x1,x2,x)
% ===== input =====
% x1, x2: time point
% x: whole time series

% ===== output =====
% MI: mutual information

len = length(x);
epsilon = 1;

M1 = x1+epsilon; m1 = x1-epsilon;
idx_x1 = find((x<M1)&(x>m1));
P_x1 = length(idx_x1)/len;

M2 = x2+epsilon; m2 = x2-epsilon;
idx_x2 = find((x<M2)&(x>m2));
P_x2 = length(idx_x2)/len;

P_x1x2=0;
for i=1:length(idx_x1)
    tmp = find(idx_x2==idx_x1(i));
    P_x1x2 = P_x1x2 + length(tmp)/len;
end

% mutual information between x1 and x2
MI = P_x1x2 * log2(P_x1x2/P_x1/P_x2);

end

%% number of FNN
function cnt = numFNN(x,tau,dim,radius)
%======inputs=====
% x: 1D time series
% tau: delay
% redius: radius of sphere

%=====output=====
% cnt = number of false nearest neighbors

R_toi = 10;

Xmat = PhaseSpace(x,tau,dim);
N = size(Xmat,2);
len = length(x);

neighborsMat = zeros(N,N);
for i=1:N-1
    for j=i+1:N
        neighborsMat(i,j) = norm(Xmat(:,i)-Xmat(:,j)) < radius;
        neighborsMat(j,i) = neighborsMat(i,j);
    end
end

cnt=0;
for i=1:N-dim*tau
    idx = find(neighborsMat(i,:));
    for kk=1:length(idx)
        if (idx(kk)+tau*dim <= len) 
            % see "Determining embedding dimension", eq(4)
            a = x(i+tau*dim);
            b = x(idx(kk)+tau*dim);
            isFNN = abs(a - b) > R_toi*norm(Xmat(:,i)-Xmat(:,idx(kk)));
            cnt = cnt + isFNN;
        end
    end
end
end



%%
