function ImOut = unifqtz(img, numPartition)

img = double(img);

ImOut = zeros(size(img));
[m, n] = size(img);

tmin = min(img(:));
tmax = max(img(:));
stepsz = (tmax-tmin)/numPartition;

t = tmin:stepsz:tmax;

for i=1:m
    for j=1:n
        dists = abs(img(i,j)-t);
        [~,idx1] = min(dists);
        
        if idx1 == 1             % This condition and the next account for the boundary extremes
            idx2 = idx1 + 1;
        elseif idx1 == length(t)
            idx2 = idx1 - 1;
        elseif (t(idx1-1)<=img(i,j)) && (img(i,j)<t(idx1))
            idx2 = idx1-1;
        else
            idx2 = idx1+1;
        end
        
        ImOut(i,j) = (t(idx1) + t(idx2))/2;
        
    end
end
