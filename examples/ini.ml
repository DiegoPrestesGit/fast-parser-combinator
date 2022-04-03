type key = string
type value = string
type pair = key * value
type section = pair list

let ini: section list ParserCombinator.parser = failwith "TODO: ini parser combinator is not implemented"

let read_whole_file (file_path: string): string =
  let ch = open_in file_path in
  let n = in_channel_length ch in
  let s = really_input_string ch n in
  close_in ch;
  s

let print_sections (sections: section list) = failwith "TODO: print_sections is not implemented"

let () =
  let result = "./test.ini"
               |> read_whole_file
               |> ParserCombinator.make_input
               |> ini.run
in
match result with
  | Ok (_, sections) -> print_sections sections
  | Error error -> Printf.printf "Error happened at %d: %s"
                                  error.pos
                                  error.desc
