function ImOut = LloydMax(img, numPartition, iters)

img = double(img);

ImOut = zeros(size(img));
[m, n] = size(img);

pixMin = min(img(:));
pixMax = max(img(:));

stepsz = (pixMax - pixMin)/numPartition;

% Initialization (Uniform)
t = pixMin:stepsz:pixMax;
r = (pixMin + stepsz/2):stepsz:(pixMax - stepsz/2);

[counts, bins] = imhist(uint8(img));
p = counts/sum(counts);

% Create the quantizer (i.e. Obtain t_k and r_k parameters)
for i = 1:iters
    
    for k = 2:length(t)-1
        t(k) = (r(k)+r(k-1))/2;
    end
    
    for k = 1:length(r)
        idxs = (t(k)<=bins)&(bins<t(k+1));
        pixs = bins(idxs);
        probs = p(idxs);
        r(k) = sum(pixs.*probs)/sum(probs);
    end
end

% Perform Quantization
for i = 1:m
    for j = 1:n
        dists = abs(img(i,j)-t);
        [~, idx] = min(dists);
        if idx == 1                        % This and the next condition account for extreme boundaries
            ImOut(i,j) = r(idx);
        elseif idx == length(t)
            ImOut(i,j) = r(idx-1);
        elseif (t(idx-1)<=img(i,j)) && (img(i,j)<t(idx))
            ImOut(i,j) = r(idx-1);
        else
            ImOut(i,j) = r(idx);
        end
    end
end

    
    
    