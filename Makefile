ini: src/parserCombinator.ml examples/ini.ml
		ocamlfind ocamlopt -I src/ -I examples/ -o ini src/parserCombinator.ml examples/ini.ml
