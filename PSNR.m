function Psnr = PSNR(origIm, estIm)


if isa(origIm, 'double')
    %A = 1;
    A = max(max(origIm));
else
    A = intmax(class(origIm));
    A = double(A);
end
    
origIm = double(origIm);
estIm = double(estIm);
    
[m, n] = size(origIm);
MSE = sum(sum((origIm-estIm).^2))/(m*n);
    
assert(strcmp(class(origIm), class(estIm)))
    
Psnr = 10*log10(double((A^2)/MSE));
    
