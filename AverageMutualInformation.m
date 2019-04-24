function AMI = AverageMutualInformation(x,tau)
% ===== input =====
% x: whole time series
% tau: delay

% ===== output =====
% AMI: Average mutual information


len = length(x);
for i=1:len-tau
    AMI = AMI + MutualInformation(x(i),x(i+tau),x);
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
epsilon = 0.01;

M1 = x1+epsilon; m1 = x1-epsilon;
idx_x1 = find((x<M1)&(x>m1));
P_x1 = length(idx_x1)/len;

M2 = x2+epsilon; m2 = x2-epsilon;
idx_x2 = find((x<M2)&(x>m2));
P_x2 = length(idx_x2)/len;

P_x1x2=0;
for i=1:length(idx_x1)
    for j=1:length(idx_x2)
        P_x1x2 = P_x1x2 + (idx_x1(i)==idx_x2(j))/len;
    end
end

% mutual information between x1 and x2
MI = P_x1x2 * log2(P_x1x2/P_x1/P_x2);
end


