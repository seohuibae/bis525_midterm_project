function [RR, DET, LAM, L , TT, DIV, ENTR] = RecurrenceMeasures(Rmat)
N = size(Rmat,1);

%% find l
lspace=1:N;
l=0;
ls=[];
for ii=1:N
    if Rmat(ii,ii)==1 
        l=l+1;
    else
        ls=[ls l];
        l=0;
    end
end
ls=ls(find(ls~=0));
lmin=min(ls);
Pl=hist(ls,lspace)/length(ls);
%% find v

vspace=1:N;
vs=[];
for ii=1:N
    tmp=find(Rmat(:,ii)==1);
    v=0;
    for t=1:length(tmp)-1
        if ((tmp(t+1)-tmp(t)) == 1) % continuous
            v=v+1;
        elseif ((tmp(t+1)-tmp(t)) > 1 )
            vs=[vs v];
            v=0;
        end
    end
end
vs=vs(find(vs~=0));
vmin=min(vs);
Pv=hist(vs,vspace)/length(vs);


%% RQA
Lmin=2;

N1=size(Rmat,1);
Yout=zeros(1,N1);
for k=2:N1
    On=1;
    while On<=N1+1-k
        if Rmat(On,k+On-1)==1
            A=1;off=0;
            while off==0 & On~=N1+1-k
                if Rmat(On+1,k+On)==1
                    A=A+1;On=On+1;
                else
                    off=1;
                end
            end
            Yout(A)=Yout(A)+1;
        end 
        On=On+1;
    end
end
Rmat=Rmat';
for k=2:N1
    On=1;
    while On<=N1+1-k
        if Rmat(On,k+On-1)==1
            A=1;off=0;
            while off==0 & On~=N1+1-k
                if Rmat(On+1,k+On)==1
                    A=A+1;On=On+1;
                else
                    off=1;
                end
            end
            Yout(A)=Yout(A)+1;
        end 
        On=On+1;
    end
end
S=Yout;
Rmat=Rmat';


%% recurrence rate (RR)
SR=0;
for i=1:N1
    SR=SR+i*S(i);
end
RR=SR/(N1*(N1-1));
%% determinism (%DET): (#points in diagonal lines)/(#recurrent points)
if SR==0
    DET=0;
else
    DET=(SR-sum(S(1:Lmin-1)))/SR;
end

%% LAM: (#points in vertical lines)/(#recurrent points)
LAM = 0;

%% L: averaged diagonal line length
L_num = 0;
L_denom = 0';
for ii=lmin:N
    L_num = L_num + lspace(ii)*Pl(ii);
    L_denom = L_denom + Pl(ii);
end
L = L_num / L_denom;

%% TT : trapping time
TT_num = 0;
TT_denom = 0';
for ii=vmin:N
    TT_num = TT_num + vspace(ii)*Pv(ii);
    TT_denom = TT_denom + Pv(ii);
end
TT = TT_num / TT_denom; 

%% DIV: maximal diagonal line length, divergence
DIV = 1/max(l);

% %% ENTR: shannons' entropy of p(l) that a diagonal line has exactly length l 
% pl = Pl./DET_num;
% ENTR = 0;
% for ii=lmin:N
%     ENTR = ENTR + pl(ii)*log(pl(ii));
% end
% ENTR = (-1)* ENTR;

%% ENTR = entropy (ENTR)
pp=S/sum(S);
entropy=0;
F=find(S(Lmin:end));
l=length(F);
if l==0
    ENTR=0;
else
    F=F+Lmin-1;
    ENTR=-sum(pp(F).*log(pp(F)));
end


