function [y, errorAmplitude, errorSpec, fourierCoeff, sortedValues] = SurrogateDataGenerator(template)
% an implementation of the iterative amplitude adapted Fourier Transform method of Schreiber and Schmitz to make surrogate time series.

% ===== inputs =====
% template: 1D time series signal
% ===== outputs =====
% y: 1D IAAFT surrogate time series
% errorAmplitude: The amount of addaption that was made in the last amplitude addaption relative to the total standard deviation.
% errorSpec: The amont of addaption that was made in the last fourier coefficient addaption relative to the total standard deviation
% fourierCoeff: The 1 dimensional Fourier coefficients that describe the structure and implicitely pass the size of the matrix
% sortedValues: A vector with all the wanted amplitudes (e.g. LWC of LWP values) sorted in acending order.
% ===== outputs =====

% reference: https://kr.mathworks.com/matlabcentral/fileexchange/4783-surrogate-time-series-and-fields

meanValue = mean(template);
sortedValues = sort(template - meanValue);
fourierCoeff = abs(ifft(template - meanValue))';

% Settings
errorThresshold = 2e-4; %
timeThresshold  = Inf;  % Time in seconds or Inf to remove this condition
speedThresshold = 1e-5; % Minimal convergence speed in the maximum error.

% Initialse function
errorAmplitude = 1;
errorSpec = 1;
oldTotalError = 100;
speed = 1;
standardDeviation = std(sortedValues);
t = cputime;
% The method starts with a randomized uncorrelated time series y with the pdf of sorted_values
[dummy,index]=sort(rand(size(sortedValues)));
y(index) = sortedValues;

% Main intiative loop
while ( (errorAmplitude > errorThresshold || errorSpec > errorThresshold) && (cputime-t < timeThresshold) && (speed > speedThresshold) )
    % addapt the power spectrum
    oldSurrogate = y;    
    x=ifft(y);
    phase = angle(x);
    x = fourierCoeff .* exp(1i*phase);
    y = fft(x);
    difference=mean(mean(abs(real(y)-real(oldSurrogate))));
    errorSpec = difference/standardDeviation;
    
    % addept the amplitude distribution
    oldSurrogate = y;
    [a,index]=sort(real(y));
    y(index)=sortedValues;
    difference=mean(mean(abs(real(y)-real(oldSurrogate))));
    errorAmplitude = difference/standardDeviation;
    
    totalError = errorSpec + errorAmplitude;
    speed = (oldTotalError - totalError) / totalError;
    oldTotalError = totalError;
end

y = real(y);
y = y + meanValue;

