function [RR, DET, LAM, L , TT, DIV, ENTR, TREND] = RecurrenceMeasures(Rmat)
N = size(Rmat,1);
RR = 1/(N^2)*sum(sum(Rmat,1)); % recurrence rate

%% find l
l = 0;
for ii=1:N
    if Rmat(i,i)==1
        l = l +1;
    else
        l = 
end
DET = 
