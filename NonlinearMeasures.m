%clear;
close all;

%% Load variables
[DIR,TITLE] = fullDir_Xmat(1,3,1,0);

a = load(DIR);
Xmat = a.Xmat;
dt = a.dt;

%% Nonlinear measure: correlation dimension
rVec=0:100:1900;

CVec = CorrelationDimension(Xmat, rVec);
D2Vec = log(CVec)./log(rVec);

figure;
plot(log(rVec), log(CVec))
xlabel('log r')
ylabel('log C(r)')
title(['D2: ',TITLE])
fprintf("D2: %f\n", D2Vec(10))

%% Nonlinear measure: largest lyapunov exponent
maxiter=size(Xmat,2)/50;
evolutionTime = (1:maxiter) * dt;

[d, lle]= LyapunovExponent(Xmat, 2, maxiter, 1/dt, 1);

figure;
plot(evolutionTime, d);
xlabel('iteration')
ylabel('divergence')
title(['Lyapunov Exp: ',TITLE]) 
fprintf("largest lyapunov exponent %f\n", lle);