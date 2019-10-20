function Q_tup = quantmtx(imtype, num, sz)

% imtype: specifies the image type for which we wish to apply the
% quantization matrix. If imtype = "gray" only one quantization matrix will
% be generated. If imtype = "YUV" two quantization matrices will be
% generated--1 for the luminance component image and 1 for chrominance
% component images.
%
% num: this parameter specifies which of the quantization matrices you
% want. I have generated multiple options. So, for example, if you want the
% second option for the quantization matrix, num = 2.
%
% sz: determines the size of the quantization matrix. Inputs for this
% parameter are 8 (for 8x8), 16 (for 16x16), and 32 (for 32x32).

if imtype == "gray"         % Generate grayscale quantization matrix
    if num == 1
        Q = toeplitz([99*ones(1,11) linspace(72, 40, 9) linspace(38, 16, 12)]);
    elseif num == 2
        Q = toeplitz([99*ones(1,22) 90 80 70 60 50 40 30 20 15, 10]);
    end
    Q = flip(tril(Q));
    scnd_half = ones(32)*99;
    scnd_half = flip(tril(scnd_half, -1), 2);
    Q = Q+scnd_half;
    
    if sz == 8
        Q = Q(1:8, 1:8);
    elseif sz == 16
        Q = Q(1:16, 1:16);
    end
    
    Q_tup = {Q};
    
elseif imtype == "YUV"
    QCh = toeplitz([99*ones(1,27) 55 45 35 25 15]);    % Generate Chrominance quantization matrix
    QCh = flip(tril(QCh));
    scnd_half = ones(32)*99;
    scnd_half = flip(tril(scnd_half, -1), 2);
    QCh = QCh+scnd_half;
    
    if num == 1
        QLm = toeplitz([99*ones(1,11) linspace(92, 12, 21)]);
    elseif num == 2
        QLm = toeplitz([99*ones(1,22) 90 80 70 60 50 40 30 20 15, 10]);
    end
    QLm = flip(tril(QLm));
    scnd_half = ones(32)*99;
    scnd_half = flip(tril(scnd_half, -1), 2);
    QLm = QLm+scnd_half;
    
    if sz == 8
        QLm = QLm(1:8, 1:8);
        QCh = QCh(1:8, 1:8);
    elseif sz == 16
        QLm = QLm(1:16, 1:16);
        QCh = QCh(1:16, 1:16);
    end
    
    Q_tup = {QLm, QCh};
    
end