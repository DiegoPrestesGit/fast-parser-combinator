.PHONY: all
all: ini.native ini.byte

ini.native: src/parserCombinator.ml examples/ini.ml
		ocamlfind ocamlopt -I src/ -I examples/ -o ini src/parserCombinator.ml examples/ini.ml

ini.byte: src/parserCombinator.ml examples/ini.ml
		ocamlfind ocamlc -I src/ -I examples/ -o ini.byte src/parserCombinator.ml examples/ini.ml
