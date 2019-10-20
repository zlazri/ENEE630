function DCTblks = dctblocks(block_img, trans)

% Performs DCT or IDCT on all blocks of an image
% trans: transform we wish to perfomr-- "DCT" or "IDCT."

DCTblks = zeros(size(block_img));
for i = 1:length(block_img(1,1,:))
    DCTblks(:,:,i) = DCT(block_img(:,:,i), trans);
end