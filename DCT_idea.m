Lena = imread('Lena.bmp');

[m, n] = size(Lena);

% Perform one level wavelet decomposition
[Idec, LL, LH, HL, HH] = wavedec(Lena, 'PR');

% Each frequency band of the image is 256x256
blksz = 256;

% Create Quantization table
q_mtx = quantmtx('gray', 1, blksz);
q_mtx = q_mtx{1};
q_mtx = [q_mtx, 200*ones(32,224)];
q_mtx = [q_mtx; 200*ones(224, 256)];

% Take the DCT transform of each frequency band
Lenablks = Img_block(Idec, blksz, blksz);
DCTblks = dctblocks(Lenablks, "DCT");

% Quantize each frequency band
DCTblks = quant_blocks(DCTblks, q_mtx);

% Convert blocks back into matrix form
DCTmtx = unblock(DCTblks, m, n);

% Calculate bpp
[counts, binLocations] = imhist(DCTmtx);

% Encode matrix and get bits per pixel
%[code, dict, bpp_dct] = Huff_encoder2(DCTmtx);

% Decode matrix and convert back into matrix form
%RC_DCTvec = Huff_decoder2(code, dict, [m, n]);
%RC_DCTmtx = reshape(RC_DCTvec, [n, m]);
%RC_DCTmtx = RC_DCTmtx';         

% Convert DCT matrix into blocks
% RC_DCTblks = Img_block(RC_DCTmtx, blksz, blksz);
RC_DCTblks = Img_block(DCTmtx, blksz, blksz);

% Inverse DCT on each block
for i = 1:length(DCTblks(1,1,:))                 % Inverse DCT to obtain image blocks
    Lenablks(:,:,i) = DCT(RC_DCTblks(:,:,i), "IDCT");
end

restored_LenaWav = unblock(Lenablks, m, n);

restored_Lena = waverec(restored_LenaWav, 'PR');

restored_Lena = img_shift(restored_Lena, 0, 2)/4;


