function E = MSE(I, I_hat)

% Determines the similarity between two images using the average-squared
% error method.

[M,N] = size(I);
E = (1/(M*N))*sum(sum((I-I_hat).^2));
