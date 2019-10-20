function [I_new, x_sec, x_hat_sec, x_hat_adj] = Img_QMF2(I, c0, c1, n0, n1, sec)

% This function takes an image, flattens it to become a 1D signal, and
% passes it through a two-channel QMF bank. a 1D signal x_hat is produced
% from this fitler banks, which can be restructured to produce the
% reconstructed 2D signal. 
%
%----------------------Inputs-----------------------------
%
% I: Input image
%
% c0, n0, c1, n1: parameters for the analysis and synthesis filters
%
% sec: length of the section we wish to display
% 
% ---------------------Outputs---------------------------- 
% I_new: the reconstructed image from this signal after making the
% necessary scale and magnitude adjustments to the 1D signal
%
% x_sec: A section of the 1D input signal, which can be used for
% display purposes (since the signal could be large, the whole thing is not
% displayed)
%
% x_hat_sec: The corresponding section of the reconstructed signal.
%
% x_hat_adj: The corresponding section of the reconstructed signal after it
% has been scaled and shifted appropriately.
%---------------------------------------------------------
[sz1, sz2] = size(I);
x = I(:)';
l = length(x);
x_sec = x(1:sec);

% Construct analysis and synthesis filters:
h0 = zeros(1, l);
h1 = zeros(1, l);
f0 = zeros(1, l);
f1 = zeros(1, l);

z1 = 2*n0 + 1; % <---extra plus 1 to account for matlab indexing
z2 = 2*n1 + 1 + 1; % <--- ""

h0(z1) = c0;
h0(z2) = c1;
h1(z1) = c0;
h1(z2) = -c1;
f0(z1) = c0;
f0(z2) = c1;
f1(z1) = -c0;
f1(z2) = c1;

% DFT
X = fft(x);
H0 = fft(h0);
H1 = fft(h1);
F0 = fft(f0);
F1 = fft(f1);

% Analysis filtering
X0 = H0.*X;
X1 = H1.*X;

% Downsample by 2
x0 = ifft(X0);
x1 = ifft(X1);
v0 = downsample(x0,2);
v1 = downsample(x1,2);

% Upsample by 2
y0 = upsample(v0, 2);
y1 = upsample(v1, 2);

% Synthesis filtereing
Y0 = fft(y0);
Y1 = fft(y1);
R0 = F0.*Y0;
R1 = F1.*Y1;

X_hat = R0 + R1;
x_hat = ifft(X_hat);

x_hat_sec = x_hat(1:sec);
M = 2*c0*c1;
N = 1 + 2*n0 + 2*n1;
x_adj = shift_scale(x_hat, N, M);
x_hat_adj = x_adj(1:sec);
I_new = reshape(x_adj, [sz1, sz2]);

% FIX BUG: I think it is related to indexing problem.