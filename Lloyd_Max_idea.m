Lena = imread('Lena.bmp');

[m, n] = size(Lena);

% Perform one level wavelet decomposition
[Idec, LL, LH, HL, HH] = wavedec(Lena, 'PR');

% LLoyd-Max Quantization
Idec = LloydMax(Idec, 200, 10);

restored_Lena = waverec(Idec, 'PR');
restored_Lena = img_shift(restored_Lena, 1, 1)/4;