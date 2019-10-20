function Inew = img_shift(I, dx, dy)

% This function performs 2D shifting of a periodic signal first by shifting
% the coordinates in the x direction, followed by shifting the coordinates
% in the y direction.

[m, n] = size(I);

for i = 1:m
    I(i,:) = shift_scale(I(i,:),dx,1);
end

for j = 1:n
    I(:,j) = shift_scale(I(:,j),dy,1);
end

Inew = I;