Lena = imread('Lena.bmp');

[m, n] = size(Lena);

% Perform one level wavelet decomposition
[Idec, LL, LH, HL, HH] = wavedec(Lena, 'PR');

Idec = unifqtz(Idec, 32);

restored_Lena = waverec(Idec, 'PR');
restored_Lena = img_shift(restored_Lena, 1, 1)/4;
