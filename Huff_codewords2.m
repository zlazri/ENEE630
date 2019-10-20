function [f, g, bpp] = Huff_codewords2(I)

I = double(I);
bin = unique(I);
count = histc(I(:), bin);
probs = count/(sum(count));
probs = [bin, probs];
probs = sortrows(probs, 2, 'descend');
merge = [count, bin];
merge = sortrows(merge, 1, 'descend');
count = merge(:,1);
bin = merge(:,2);
L = length(bin);

bin = num2cell(bin);

Dict = {};

for i = 1:L
    Dict{i} = '';
end

bin_idx = {}';
for i = 1:length(bin)
    bin_idx{i} = i;
end

if L>1
    for i = 1:L-1
        Last = bin_idx{L-i+1};
        SecLast = bin_idx{L-i};
        
        for m = 1:length(Last)
            Dict{Last(m)} = strcat(string(1), string(Dict{Last(m)}));
        end
        
        for m = 1:length(SecLast)
            Dict{SecLast(m)} = strcat(string(0), string(Dict{SecLast(m)}));
        end
        
        bin_idx = bin_idx(1:L-1-i);
        bin_idx{L-i} = [SecLast, Last];
        count(L-i) = count(L-i) + count(L+1-i);
        count = count(1:L-i);
        countsort = [count, [1:1:length(count)]'];
        countsort = sortrows(countsort, 1, 'descend');
        count = countsort(:,1);
        sorting = countsort(:,2);
        bin_idx = bin_idx(sorting);
    end
else
    Dict{L} = string(0);
end
f = containers.Map;
g = containers.Map;

for i = 1:L
    if isempty(Dict{i})
        continue
    else
        f(char(Dict{i})) = bin{i};
    end
end

for i = 1:L
    if isempty(Dict{i})
        continue
    else
        g(char(string(bin{i}))) = char(Dict{i});
    end
end

bpp = 0;
for i = 1:L
    if any(strcmp(keys(g), {char(string(bin{i}))}))
        bpp = bpp + length( g(char(string(bin{i}))) )*probs(i,2);  % probs not properly sorted?
    end
end
