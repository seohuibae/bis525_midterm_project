function [d, lle] = LyapunovExponent(Xmat, meanperiod, maxiter, fs)
% an implementation of largest lyapunov exponent using Rosenstein's Algorithm

% ===== outputs =====
% d: divergence of nearest trajectoires
% lle: largest lyapunov exponent

% ===== inputs =====
% meanperiod: 
% Xmat: reconstructed phase space trajectories (numD * M)
% fs: sampling frequency

M=size(Xmat,2);
for i=1:M
    x0=ones(1,M).*Xmat(:,i);
    distance=sqrt(sum((Xmat-x0).^2,2));
    for j=1:M
        if abs(j-i)<=meanperiod
            distance(j)=1e10;
        end
    end
    [neardis(i) nearpos(i)]=min(distance);
end

for k=1:maxiter
    maxind=M-k;
    evolve=0;
    pt=0;
    for j=1:M
        if j<=maxind && nearpos(j)<=maxind
            dist_k=sqrt(sum((Xmat(:,j+k)-Xmat(:,nearpos(j)+k)).^2,1));
             if dist_k~=0
                evolve=evolve+log(dist_k);
                pt=pt+1;
             end
        end
    end
    if pt > 0
        d(k)=evolve/pt;
    else
        d(k)=0;
    end
    
end

%% LLE Calculation
tlinear=15:78;
F = polyfit(tlinear,d(tlinear),1);
lle = F(1)*fs;




