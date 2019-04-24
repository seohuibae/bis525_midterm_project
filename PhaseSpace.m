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