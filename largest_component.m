function [Acc p]=largest_component(A)
[ci sizes] = components(A);
[csize cind] = max(sizes);
p = ci==cind;
Acc = A(p,p);
    