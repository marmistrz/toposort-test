# see: http://www.ocaml.info/home/ocaml_sources.html#toc16
PACKS = oUnit

# put here the names of your source files (in the right order)
SOURCES = graph.ml pMap.mli pMap.ml topol.mli topol.ml topoltools.mli topoltools.ml test.ml

# the name of the resulting executable
RESULT  = test

# generate type information (.annot files)
ANNOTATE = yes

# make target (see manual) : byte-code, debug-code, native-code, ...
all: debug-code run

include OCamlMakefile

MODULE = $(SOURCES)
run:
	./test