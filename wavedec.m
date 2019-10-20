function [Idec, LL, LH, HL, HH] = wavedec(img, hspec)

% Performs one level of wavelet decomposition
%
%img: input image
%
% hspec: Specifies which wavelet we want to use ('haar', 'db2', etc.)

[m, n, k] = size(img);

img = double(img);

if isequal(hspec,'PR')
    [hLo, hHi, hrecLo, hrecHi] = PR_filters(1, 1, 0, 0, n);
else
    [hLo, hHi, hrecLo, hrecHi] = wfilters(hspec); % Get the filters
end
hL = zeros(1,n);
hH = zeros(1,n);
hrecL = zeros(1,n);
hrecH = zeros(1,n);
hL(1:length(hLo)) = hLo;
hH(1:length(hHi)) = hHi;
hrecL(1:length(hrecLo)) = hrecLo;
hrecH(1:length(hrecHi)) = hrecHi;


% Perform transform
L = zeros(m, n, k);
H = zeros(m, n, k);

for l = 1:k
    for i = 1:n     % Filter rows
        L(:,i,l) = ifft(fft(hL').*fft(img(:,i,l)));
        H(:,i,l) = ifft(fft(hH').*fft(img(:,i,l)));
    end
end

L = L(1:2:m,:,:); % Downsample rows by 2
H = H(1:2:m,:,:);
% hL = hL(1:length(hL)/2);
% hH = hH(1:length(hH)/2);


[m1, n1, k] = size(L);

LL = zeros(m1, n1, k);
LH = zeros(m1, n1, k);
HL = zeros(m1, n1, k);
HH = zeros(m1, n1, k);

for l = 1:k
    for i = 1:m1    % Filter columns        
        LL(i,:,l) = ifft(fft(hL).*fft(L(i,:,l)));
        LH(i,:,l) = ifft(fft(hH).*fft(L(i,:,l)));
        HL(i,:,l) = ifft(fft(hL).*fft(H(i,:,l)));
        HH(i,:,l) = ifft(fft(hH).*fft(H(i,:,l)));
    end
end

LL = LL(:,1:2:n1,:); % Downsample columns by 2
LH = LH(:,1:2:n1,:);
HL = HL(:,1:2:n1,:);
HH = HH(:,1:2:n1,:);

Idec = zeros(m,n);
Idec(1:m/2,1:n/2) = LL;
Idec(1:m/2, n/2+1:end) = LH;
Idec(m/2+1:end, 1:n/2) = HL;
Idec(m/2+1:end, n/2+1:end) = HH;



