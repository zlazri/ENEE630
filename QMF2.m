function x_hat = QMF2(x, h0, h1, f0, f1)

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