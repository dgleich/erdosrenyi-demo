function im=er_evolution_figure(n,filename,thresh_plot,steps)
% ER_EVOLUTION_FIGURE Produce an animated gif for an erdos-reyni evolution.
%
% ER_EVOLUTION_FIGURE(n) produces
%   er-<n>.gif 
% with a pause (repeated frame) at the giant component threshold

% get random data
A = rand(n);
A = triu(A,1);
A = A + A';

G = @(p) A < p;

if ~exist('filename','var') || isempty(filename)
    filename = sprintf('er-%d.gif',n);
end

thres_conn = log(n)/(n);
thres_big = 1/(n-1);

if ~exist('thresh_plot','var') || isempty(thresh_plot)
    thres_plot = sqrt(thres_conn*thres_big);
end

if ~exist('steps','var') || isempty(steps)
    
    t1 = linspace(0, thres_big, 50);
    t2 = linspace(thres_big, thres_conn, 100);

    % pause for a second at the critical threshold
    steps = [t1 ones(1,40)*thres_big t2];
    
end

% determine the layout

Gt = G(thres_plot);
[x y] = neato_layout(Gt);
[Gcc p] = largest_component(Gt);

% plot a single frame to find the colormap
gplot(Gt, [x', y'],'bo-'); hold on;
gplot(Gcc, [x(p)' y(p)'], 'ro-'); 
title('test');
set(gcf,'Color',[1,1,1]);
hold off;

axis off
drawnow;
f = getframe(gcf);

[im1,map] = rgb2ind(f.cdata,256,'nodither');

clf;

% setup the image
nframes = length(steps);
im = zeros(size(im1,1),size(im1,2),1,nframes);

for frame=1:nframes
    step = steps(frame);
    
    Gcur = G(step);    
    gplot(Gcur, [x' y'],'bo-'); hold on;
    plot(x', y', 'bo');
    [Glc p] = largest_component(Gcur);
    gplot(Glc, [x(p)' y(p)'], 'ro-');
    hold off;
    
    set(gcf,'Color',[1,1,1]);
    axis off;

    title({sprintf('p = %d', step), sprintf('p*n = %d', step*n)});
    
    drawnow;
    
    f = getframe(gcf);
    im(:,:,1,frame) = rgb2ind(f.cdata,map,'nodither');
end

% not sure when the "+1" become required, but it seems to be!
imwrite(im+1,map,filename,'DelayTime',0.1,'LoopCount',inf);
    

