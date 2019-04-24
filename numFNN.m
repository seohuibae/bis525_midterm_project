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
        if idx(kk)+tau*dim <= len
            % see "Determining embedding dimension", eq(4)
            a = x(i+tau*dim);
            b = x(idx(kk)+tau*dim);
            isFNN = abs(a - b) > R_toi*norm(Xmat(:,i)-Xmat(:,idx(kk)));
            cnt = cnt + isFNN;
        end
    end
end
end
    