
n = 150;
name = sprintf('er-%i', n);

%rand('seed', 100);

A = rand(n);
A = triu(A,1);
A = A + A';

G = @(p) A < p;
thres_conn = (log(n))/(n);
thres_big = 1/(n-1);

thres = sqrt(thres_conn*thres_big);

Gt = G(thres);
[x y] = draw_dot(Gt);
close(gcf);


t1 = linspace(0, thres_giant, 50);
t2 = linspace(thres_giant, thres_conn, 100);

t = [t1 ones(1,40)*thres_giant t2];

pspec1 = [];
pspec2 = [];

f = 1;
pl = linspace(1, .15, 25);

for (tt = t)
    % plot the graph
    gplot(G(tt), [x' y'], 'b.-');
    hold on;
    % plot the largest component of the graph
    [Glc p] = largest_component(G(tt));
    gplot(Glc, [x(p)' y(p)'], 'r');
    hold off;
    set(gca, 'YTick', []);
    set(gca, 'XTick', []);
    set(gcf, 'Color', [1 1 1]);
    
    title(sprintf('p = %d', tt));
    
    pause(0.15);
    
    cf = getframe(gcf);
    imwrite(frame2im(cf), sprintf('%s-%03i.png', name, f));
    
    f = f+1;
end;



