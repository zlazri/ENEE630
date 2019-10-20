function [code, f, bpp] = Huff_encoder2(I)

[f,g, bpp] = Huff_codewords2(I);
[m, n, chan] = size(I);
code = '';
for k = 1:chan
    for i = 1:m
        for j = 1:n
            pixel = I(i,j,k);
            pixel_code = g(char(string(pixel)));
            code = strcat(code, pixel_code);
        end
    end
end