function blkIm = Img_block(img, m_sz, n_sz)

img = double(img);
[m, n] = size(img);

assert(mod(m,m_sz)==0);
assert(mod(n,n_sz)==0);

m_length = m/m_sz;
n_length = n/n_sz;

num_blks = m_length*n_length;
blkIm = zeros(m_sz, n_sz, num_blks);
idx = 1;

for i = 1:m_length
    for j = 1:n_length
        blkIm(:,:,idx) = img((i-1)*m_sz+1:i*m_sz, (j-1)*n_sz+1:j*n_sz);
        idx = idx+1;
    end
end