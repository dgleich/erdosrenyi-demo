Erdős-Réyni Random Graphs with Matlab
=====================================

### David Gleich, Purdue University
<http://www.cs.purdue.edu/homes/dgleich>    
_Last updated 2011-09-08_

In this tutorial, we'll look at generating Erdős-Réyni
random random graphs in Matlab -- something that will
be rather easy -- and then look at how the so-called
_giant component_ evolves in these graphs.

This tutorial is not meant to be mathematical, but rather,
an empirical demonstration.  For mathematical references see:

* Wikipedia: 
  [Erdős–Rényi model](http://en.wikipedia.org/wiki/Erd%C5%91s%E2%80%93R%C3%A9nyi_model)
* Amin Saberi's MS&E 337 Lecture Notes: 
  [Emergence of the giant connected component](http://www.stanford.edu/class/msande337/notes/lec1.pdf)

Other empirical demonstration of the same phenomenon:

* <http://www.ubietylab.net/ubigraph/content/Demos/RandomGraph.html>
* <http://networkx.lanl.gov/examples/drawing/giant_component.html>

Getting everything working
--------------------------

The following demo needs a few helper codes.  If you just want to
see what's going on, feel free to skip this section.  But if you
want to run things, you'll need the following codes.

* `components.m` -- A file from the 
  [MESHPART toolkit](http://www.cerfacs.fr/algor/Softs/MESHPART/)
* `neato_layout.m` -- A file based on drawGraph.m and draw_dot.m from 
  [AT&T GraphViz/Matlab interface](http://www.mathworks.com/matlabcentral/fileexchange/4518)
  and <http://code.google.com/p/matlabtools/source/browse/trunk/graphics/drawGraph.m?r=121&spec=svn121>
* `graph_to_dot.m` -- from  [AT&T GraphViz/Matlab interface](http://www.mathworks.com/matlabcentral/fileexchange/4518)
* `neato` -- the graph layout program from [AT&T GraphViz](http://www.graphviz.org/)

Some of these files need some edits due to changes in graphviz
and Matlab.

I've packaged all the updated Matlab files into a single zip file
or github repository

* [Erdős-Rényi matlab files](erdos_reyni.zip)
* [Erdős-Rényi github repo](https://github.com/dgleich/erdosrenyi-demo) @ github

This includes `components.m`, `neato_layout.m` (and support files),
as well as all the matlab scripts here. 

### Installing graphviz

* _ubuntu_ just use apt-get 

    sudo apt-get install graphviz
    
* _OSX_ use homebrew to install graphviz

    brew install graphviz
    
For OSX, you may also need to run the following command in Matlab
to add neato to the path

    setenv('PATH', [getenv('PATH') ':/usr/local/bin']);
    
* _Windows_ Install graphviz from the precompiled binaries, see
[AT&T GraphViz](http://www.graphviz.org/)

Examples
--------

1. [Generating an Erdős-Réyni graph in Matlab](generate.html)
   [(matlab)](generate.m)
2. [Watching the evolution](evolution.html)
   [(matlab)](evolution.m)
3. [50 node ER graph evolution](er-50.gif)
4. [100 node ER graph evolution](er-100.gif)
5. [150 node ER graph evolution](er-150.gif)

The last few files were generated via the function `er_evolution_figure`
(matlab code <./er_evolution_figure.m>)



