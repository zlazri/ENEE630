function Img = unblock(blkIm, m, n)

blkIm = double(blkIm);

Img = zeros(m,n);
[m_sz, n_sz] = size(blkIm(:,:,1));

mblk = m/m_sz;
nblk = n/n_sz;
idx = 1;

for i = 1:mblk
    for j = 1:nblk
        Img((i-1)*m_sz+1 : i*m_sz, (j-1)*n_sz+1 : j*n_sz) = blkIm(:,:,idx);
        idx = idx+1;
    end
end