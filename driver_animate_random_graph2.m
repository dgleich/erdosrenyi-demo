if (~exist('n', 'var') || ~exist('A', 'var') || ...
    ~exist('G', 'var') || ~exist('x', 'var') || ...
    ~exist('y', 'var') || ~exist('thres_conn', 'var') || ...
    ~exist('thres_giant', 'var'))

    error('need n, A, G, x, y, thres_conn, thres_giant defined');
end;


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
    imwrite(frame2im(cf), sprintf('rg-200-%03i.png', f));
    
    f = f+1;
end;



