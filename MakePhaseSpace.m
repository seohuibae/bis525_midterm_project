clear 
clc
dir = fullDir(2,3);
file = [dir,sprintf('/EEG_%d.txt',1)];
data = importdata(file);

time = data(:,1);
EEG = data(:,2);
dt = time(2) - time(1);
[Xmat, tau, numD, tauVec,FNN, AMIVec, dimVec] = ReconstructPhaseSpace(EEG);
save Xmat_Patient_C_1.mat

clear
clc
load('Xmat_Patient_C_1.mat');
[y, errorAmplitude, errorSpec, fourierCoeff, sortedValues] = SurrogateDataGenerator(EEG);
[Xmat, tau, numD, tauVec,FNN, AMIVec, dimVec] = ReconstructPhaseSpace(y);
save Xmat_Patient_C_1_surrogate.mat