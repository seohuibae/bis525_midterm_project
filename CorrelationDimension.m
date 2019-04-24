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
    cntVec = zeros(1,size(Xmat,2)-1);
    for i=1:size(Xmat,2)-1
        cntVec(i) = NearestNeighbors(Xmat,Xmat(:,i:i+1),r);
    end
    C = 1/N^.2*sum(cntVec);
    CVec(ii)= C; 
    disp(C)
end



    
    
end