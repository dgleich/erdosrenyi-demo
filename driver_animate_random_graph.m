if (~exist('n', 'var') || ~exist('A', 'var') || ...
    ~exist('G', 'var') || ~exist('x', 'var') || ...
    ~exist('y', 'var') || ~exist('thres_conn', 'var') || ...
    ~exist('thres_giant', 'var'))

    error('need n, A, G, x, y, thres_conn, thres_giant defined');
end;


t1 = linspace(0, thres_giant, 50);
t2 = linspace(thres_big, thres_conn, 100);

t = [t1 ones(1,40)*thres_big t2];

pspec1 = [];
pspec2 = [];

f = 1;
pl = linspace(1, .15, 25);

for (tt = t)
    % plot the graph
    subplot(4,2,[1 2 3 4 5 6]);
    gplot(G(tt), [x' y'], 'b.-');
    hold on;
    % plot the largest component of the graph
    [Glc p] = largest_component(G(tt));
    gplot(Glc, [x(p)' y(p)'], 'r');
    hold off;
    
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
    
    if (f > length(pl))
        pause(0.15);
    else
        pause(pl(f));
    end;
    
    f = f+1;
end;



