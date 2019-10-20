function N = SNR(origIm, estIm)

% Calculates the mean-square signal-to-noise ratio between original and
% estimated image

% Calculate numerator
numer = estIm.^2;
numer = sum(sum(numer));

% Calculate denominator
denom = (origIm-estIm).^2;
denom = sum(sum(denom));

N = numer/denom;