function Y = DCT(img, transform)

img = double(img);

[m, n] = size(img);
C = zeros(m,n);

for i = 0:m-1
    for j = 0:m-1
        if i == 0
            C1(i+1,j+1) = (1/sqrt(m))*cos((pi*(2*j+1)*i)/(2*m));
        else
            C1(i+1,j+1) = sqrt(2/m)*cos((pi*(2*j+1)*i)/(2*m));
        end
    end
end

for i = 0:n-1
    for j = 0:n-1
        if i == 0
            C2(i+1,j+1) = (1/sqrt(n))*cos((pi*(2*j+1)*i)/(2*n));
        else
            C2(i+1,j+1) = sqrt(2/n)*cos((pi*(2*j+1)*i)/(2*n));
        end
    end
end

if transform == "DCT"
    Y = C1*img*C2';
elseif transform == "IDCT"
    Y = C1'*img*C2;
end
