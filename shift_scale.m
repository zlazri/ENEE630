function x_new = shift_scale(x, N, M)

% This function shifts and scales a 1D signal as desired by the user.
%
% x: The input signal
%
% N: The number of time units the we wish to shift the input signal (left)
%
% M: The magnitude by which we scale the input signal
%
% x_new: The ouput signal after shifting and scaling

l = length(x);

x_new = zeros(1,l);

% Shift
x_new(1:end-N) = x(N+1:end);
wrap = x(1:N);
x_new(end-N+1:end) = wrap;

% Scale
x_new = x_new/M;