function d = fdelta(n0, idx1, idx2)

% n0: parameter such that we have Delt[n-n0], where Delt is the delta
% function
%
% idx1: first nonzero index of signal
%
% idx2: last nonzero index of signal

l = idx2 - idx1 + 1;

d = zeros(1,l);

d(n0) = 1;