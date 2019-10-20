function qtzblocks = quant_blocks(block_img, q_mtx)

% Applies quantization to each block of an image

qtzblocks = zeros(size(block_img));
for i = 1:length(block_img(1,1,:))         % Quantize each block
    k = round(block_img(:,:,i)./q_mtx);
    qtzblocks(:,:,i) = k.*q_mtx;  
end