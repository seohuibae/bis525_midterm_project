clear;
close all;

%% Load variables
[DIR,TITLE] = fullDir_Xmat(2,1,2,1);

a = load(DIR);
Xmat = a.Xmat;
dt = a.dt;

%% Nonlinear measure: correlation dimension
rVec=0:100:1900;

CVec = CorrelationDimension(Xmat, rVec);
D2Vec = diff(log(CVec))./diff(log(rVec));
D2 = nanmax(D2Vec);

figure;
plot(log(rVec), log(CVec))
xlabel('log r')
ylabel('log C(r)')
title([TITLE,  'D2: ',])

%% Nonlinear measure: largest lyapunov exponent
maxiter=size(Xmat,2)/50;
evolutionTime = (1:maxiter) * dt ;

[d, lle]= LyapunovExponent(Xmat, 2, maxiter, 1/dt, 1);

figure;
plot(evolutionTime, d);
xlabel('iteration')
ylabel('divergence')
title([TITLE, ' Lyapunov Exp: ',num2str(lle)]) 
fprintf("largest lyapunov exponent %f\n", lle);