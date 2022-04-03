type key = string
type value = string
type pair = key * value
type section = pair list

let ini: section list ParserCombinator.parser = failwith "TODO"

let read_whole_file (file_path: string): string = failwith "TODO"

let print_sections (sections: section list) = failwith "TODO"

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
