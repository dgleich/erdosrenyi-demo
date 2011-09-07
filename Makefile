
all: generate.html evolution.html er-50.gif er-100.gif er-150.gif index.html erdos_renyi.zip

generate.html: generate.m
	matlab -nodisplay -r "restoredefaultpath;matlabrc;slCharacterEncoding('UTF-8');publish('generate',struct('outputDir','.')); exit"
	reset

evolution.html: evolution.m
	matlab -nodisplay -r "restoredefaultpath;matlabrc;slCharacterEncoding('UTF-8');publish('evolution',struct('outputDir','.')); exit"
	reset

er-50.gif: er_evolution_figure.m
	matlab -r "restoredefaultpath;matlabrc;slCharacterEncoding('UTF-8');er_evolution_figure(50); exit"
	reset

er-100.gif: er_evolution_figure.m
	matlab  -r "restoredefaultpath;matlabrc;slCharacterEncoding('UTF-8');er_evolution_figure(100); exit"
	reset
	
er-150.gif: er_evolution_figure.m
	matlab  -r "restoredefaultpath;matlabrc;slCharacterEncoding('UTF-8');er_evolution_figure(150); exit"
	reset
	
index.html: erdosrenyi.md
	maruku erdosrenyi.md -o index.html

zipfiles := components.m neato_layout.m graph_to_dot.m matlab-graphviz-license.txt \
            evolution.m generate.m er_evolution_figure.m \
            erdosrenyi.md er-50.gif er-100.gif er-150.gif

erdos_renyi.zip: $(zipfiles)
	zip add erdos_reyni.zip $(zipfiles)
	
