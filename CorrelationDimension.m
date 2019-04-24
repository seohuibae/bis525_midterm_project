function CVec=CorrelationDimension(Xmat, rVec)
%======inputs=====
% Xmat: whole data points in phase space (numD * num of points)
% rVec: radius of sphere (will be scanned through) (1 * p)

%=====output=====
% CVec: correlation function C(r) for r

N = size(Xmat, 2);
CVec = zeros(1,length(rVec));
for ii=1:length(rVec)
    r = rVec(ii);
    cntVec = zeros(1,size(Xmat,2));
    for i=1:size(Xmat,2)
        for j=i+1:size(Xmat,2)
            Xvecs=Xmat(:,j);
            tmp(j) = norm(Xmat(:,i)-Xvecs) < r; %bool
        end
        cntVec(i) = sum(tmp);
    end
    C = 2/(N*(N-1))^.2*sum(cntVec);
    CVec(ii)= C; 
end



    
    
end