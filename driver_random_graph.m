n = 150;

rand('seed', 100);

A = rand(n);
A = triu(A,1);
A = A + A';

G = @(p) A < p;
thres_conn = log(n)/(n);
thres_big = 1/(n-1);

thres = sqrt(thres_conn*thres_big);

Gt = G(thres);
[x y] = draw_dot(Gt);
close(gcf);

subplot(4,2,1);
gplot(G(thres_big), [x' y']);
title('p = giant component threshold');

subplot(4,2,2);
gplot(G(thres_conn), [x' y']);
title('p = connected threshold');

t1 = linspace(0, thres_big, 50);
t2 = linspace(thres_big, thres_conn, 100);

t = [t1 ones(1,40)*thres_big t2];

pspec1 = [];
pspec2 = [];

f = 1;

for (tt = t)
    subplot(4,2,[3 4 5 6]);
    gplot(G(tt), [x' y']);
    
    title(sprintf('p = %d', tt));
    subplot(4,2,[7 8]);
    C = components(G(tt));
    R = sparse(1:n, C, 1, n, max(C));
    numC = max(C);
    comp_sizes = sum(R);
    pspec2 = [pspec2 comp_sizes];
    pspec1 = [pspec1 ones(1,numC)*tt];
    plot(pspec1, pspec2, '.');
    title('size of components');
    xlabel('p');
    
    %subplot(4,2, 8);
    %[N,X] = hist(comp_sizes, 1:n);
    %barh(X,N);
    pause(0.05);
    M(f) = getframe(gcf);
    
    
    imwrite(frame2im(M(f)), sprintf('erdosreyni-anim-%03d.png', f));
    f = f+1;
end;


