function Irec = waverec(Idec, hspec)

[m, n, k] = size(Idec);
m1 = m/2;
n1 = n;

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

LL = Idec(1:m1, 1:m1);
LH = Idec(1:m1, m1+1:end);
HL = Idec(m1+1:end, 1:m1);
HH = Idec(m1+1:end, m1+1:end);

LLrec = zeros(m1,n1);
LHrec = zeros(m1,n1);
HLrec = zeros(m1,n1);
HHrec = zeros(m1,n1);

LLrec(:,1:2:n1) = LL;
LHrec(:,1:2:n1) = LH;
HLrec(:,1:2:n1) = HL;
HHrec(:,1:2:n1) = HH;

for l = 1:k
    for i = 1:m1    % Filter columns        
        LLrec(i,:,l) = ifft(fft(hrecL).*fft(LLrec(i,:,l)));
        LHrec(i,:,l) = ifft(fft(hrecH).*fft(LHrec(i,:,l)));
        HLrec(i,:,l) = ifft(fft(hrecL).*fft(HLrec(i,:,l)));
        HHrec(i,:,l) = ifft(fft(hrecH).*fft(HHrec(i,:,l)));
    end
end

L = LHrec + LLrec;
H = HLrec + HHrec;

Lrec = zeros(m,n);
Hrec = zeros(m,n);

Lrec(1:2:m,:) = L;
Hrec(1:2:m,:) = H;

for l = 1:k
    for i = 1:n     % Filter rows
        Lrec(:,i,l) = ifft(fft(hrecL').*fft(Lrec(:,i,l)));
        Hrec(:,i,l) = ifft(fft(hrecH').*fft(Hrec(:,i,l)));
    end
end

Irec = Lrec + Hrec;