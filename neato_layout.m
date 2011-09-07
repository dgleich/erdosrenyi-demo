function [x, y] = neato_layout(adj)
%
% [x, y] = neato_layout(adj)   layout a graph defined by adjacency matrix 
%   using the GraphViz neato program
% 
% Based on draw_dot in the GraphViz layout tools and readCoordsFromDotFile
% by KPM

% (C) Dr. Leon Peshkin  pesha @ ai.mit.edu  /~pesha     24 Feb 2004
% Modified by David Gleich 2011 using code from readCoordsFromDotFile

[n,m] = size(adj);
   if n ~= m, warning('not a square adjacency matrix!'); end
   if isequal(triu(adj,1),tril(adj,-1)'), directed = 0; else, directed = 1; end 
adj = double(adj > 0);    % make sure it is a binary matrix cast to double type
      % to be platform independant no use of directories in temporary filenames
tmpDOTfile = '_GtDout.dot';           tmpLAYOUT  = '_LAYout.dot'; 
graph_to_dot(adj, 'directed', directed, 'filename', tmpDOTfile); % save in file
if ispc, shell = 'dos'; else, shell = 'unix'; end                %  Which OS ?
neato = '(''neato -Tdot  -Gmaxiter=25000 -Gregular'; % -Gstart="regular" -Gregular  
neato = strcat([neato '-Gminlen=5 -Goverlap=false ']);   % minimal edge length, no overlap   
cmnd = strcat([shell neato ' -o' tmpLAYOUT ' ' tmpDOTfile ''')']);    % -x compact
status = eval(cmnd);                 %  get NEATO to layout

[x, y] = readCoordsFromDotFile(tmpLAYOUT, n);

function [x, y, label] = readCoordsFromDotFile(filename, Nvrt)

% Given a file like this
%
% digraph G {
%       1 [pos="28,31"];
%       2 [pos="74,87"];
%       1 -- 2 [pos="e,61,71 41,47 46,53 50,58 55,64"];
%
% we return x=[28,74], y=[31,87]
% We assume nodes are numbered, not named.
% We assume all the coordinate information comes at the beginning of the file.
% We terminate as soon as we have read coords for Nvrt nodes.
% We do not read the graph structure information.

% KPM 23 May 2006

lines = textread(filename,'%s','delimiter','\n','commentstyle','c'); 
% ignoring C-style comments
dot_lines = strvcat(lines);                                           

if isempty(findstr(dot_lines(1,:), 'graph '))  
   error('* * * File does not appear to be in valid DOT format. * * *');   
end;

x = []; y = []; label = []; % in case there are no nodes...
%x = zeros(1, Nvrt); 
%y = zeros(1, Nvrt);
seenNode = zeros(1, Nvrt);
line_ndx = 1;
done = 0;
while ~done
  if line_ndx > size(dot_lines, 1) | all(seenNode)
    break
  end
  line = dot_lines(line_ndx,:);
  if ~isempty(strfind(line, '->')) | ~isempty(strfind(line, '--'))
    %finished reading location information - quitting
    break
  end
  line_ndx = line_ndx + 1;
  if isempty(strfind(line, 'pos')) % skip header info
    continue;
  end
  str = line;
  %cells =   regexp(str, '(\d+)\s+\[pos="(\d+),(\d+)', 'tokens');
  %cells =   regexp(str, '(\d+)\s+\[label=(\w+), pos="(\d+),(\d+)', 'tokens');
  
  % fixed by David Duvenaud
  % fixed again by David Gleich to have optional label
  cells = regexp(str, '(\d+)\s+\[(label=(\w+), |)pos="(\d+\.?\d+),(\d+\.?\d+)', 'tokens');
  node = str2num(cells{1}{1});
  %label(node) = str2num(cells{1}{2});
  %label{node} = num2str(cells{1}{2});
  label{node} = cells{1}{2};
  xx = str2num(cells{1}{3});
  yy = str2num(cells{1}{4});
  x(node) = xx;
  y(node) = yy;
  %fprintf('n=%d,x=%d,y=%d,%s!\n', node, xx, yy, label{node});
  seenNode(node) = 1;
end


x = .9*(x-min(x))/drange(x)+.05;  % normalize and push off margins 
if drange(y) == 0, y = .5*ones(size(y)); else, y = .9*(y-min(y))/drange(y)+.05; end

function r=drange(x)
r = max(x(:))-min(x(:));