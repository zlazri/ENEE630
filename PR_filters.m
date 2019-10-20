function [h0, h1, f0, f1] = PR_filters(c0, c1, n0, n1, l)

% Returns analysis and synthesis filters that satisfy perfect
% reconstruction property.

% Construct analysis and synthesis filters:
h0 = zeros(1, l);
h1 = zeros(1, l);
f0 = zeros(1, l);
f1 = zeros(1, l);

z1 = 2*n0 + 1; % <---extra plus 1 to account for matlab indexing
z2 = 2*n1 + 1 + 1; % <--- ""

h0(z1) = c0;
h0(z2) = c1;
h1(z1) = c0;
h1(z2) = -c1;
f0(z1) = c0;
f0(z2) = c1;
f1(z1) = -c0;
f1(z2) = c1;