function [RR, DET, LAM, L , TT, DIV, ENTR, TREND] = RecurrenceMeasures(Rmat)
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
vmin=min(vs);
Pv=hist(vs,vspace)/length(vs);

%% RR: recurrence rate 
RR = 1/(N^2)*sum(sum(Rmat,1)); % recurrence rate

%% DET

DET_num = 0;
for ii=lmin:N
    DET_num = DET_num + lspace(ii)*Pl(ii);
end
DET_denom = 0;
for ii=1:N
    DET_denom = DET_denom + lspace(ii)*Pl(ii);
end
DET = DET_num / DET_denom;

%% LAM
LAM = 0;

%% L: averaged diagonal line length
L_num = 0;
L_denom = 0';
for ii=lmin:N
    L_num = L_num + lspace(ii)*Pl(ii);
    L_denom = L_denom + Pl(ii);
end
L = L_num / L_denom;

%% TT : trapping tim
TT_num = 0;
TT_denom = 0';
for ii=vmin:N
    TT_num = TT_num + vspace(ii)*Pv(ii);
    TT_denom = TT_denom + Pv(ii);
end
TT = TT_num / TT_denom; 

%% DIV: maximal diagonal line length, divergence
DIV = 1/max(l);

%% ENTR: shannons' entropy of p(l) that a diagonal line has exactly length l 
pl = Pl./DET_num;
ENTR = 0;
for ii=lmin:N
    ENTR = ENTR + pl(ii)*log(pl(ii));
end
ENTR = (-1)* ENTR;

%% TREND: the regression coefficient of a linear relationship between the density of recurrence points in a line parallel to the LOI and its distance to the LOI.
TREND=0;
