function [K, L] = LyapunovExponent()

dd=pdist(EEM,'chebychev');
dd=squareform(dd);


mad=std(y);
dd=dd+eye(rEEM)*10*mad;


for k=0:20
for n=1:rEEM-k
    
    l1=find(0.05*(1/R2)*mad<dd(n,1:end-k)<0.1*(1/R2)*mad)';
   
    u=dd(l1+k,n+k);
    LL(n,1) = log(mean(u));
   
end
L(k+1,1)=nanmean(LL);
K(k+1,1)=k;

end

lambda=diff(L)./diff(K);


