.PHONY: all
all: ini ini.bytes


ini: src/parserCombinator.ml examples/ini.ml
		ocamlfind ocamlopt -I src/ -I examples/ -o ini src/parserCombinator.ml examples/ini.ml

ini.bytes: src/parserCombinator.ml examples/ini.ml
		ocamlfind ocamlc -I src/ -I examples/ -o ini.bytes src/parserCombinator.ml examples/ini.ml
