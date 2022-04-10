type key = string
type value = string
type pair = key * value
type section = {
  name: string;
  pairs: pair list;
}

let show_pair ((key, value): pair): string = Printf.sprintf "(%s, %s)" key value

let show_pairs (pairs: pair list): string =
  pairs
  |> List.map show_pair
  |> String.concat ","
  |> Printf.sprintf "[%s]"

let show_section (sec: section): string =
  Printf.sprintf "{name = %s; pairs = %s}"
    sec.name
    (show_pairs sec.pairs)

let show_sections (sections: section list) = sections
  |> List.map show_section
  |> String.concat ","
  |> Printf.sprintf "[%s]"

let read_whole_file (file_path: string): string =
  let ch = open_in file_path in
  let n = in_channel_length ch in
  let s = really_input_string ch n in
  close_in ch;
  s

let section_name: string ParserCombinator.parser =
  let open ParserCombinator in
  prefix "[" *> parse_while (fun x -> x != ']') <* prefix "]"

let white_spaces: string ParserCombinator.parser =
  let open ParserCombinator in
  parse_while (fun x -> x == ' ')

let pair_parser: pair ParserCombinator.parser =
  let open ParserCombinator in
  let name = parse_while (fun x -> x != ' ' && x != '=') in
  (white_spaces *> name <* white_spaces <* prefix "=" <* white_spaces) <*> name

let section_parser: section ParserCombinator.parser =
  let open ParserCombinator in
  section_name <*> many pair_parser
  |> map (fun (s, ps) -> {name = s; pairs = ps})

let ini_parser: section list ParserCombinator.parser =
  let open ParserCombinator in
  many section_parser

(* let () =
  let result = "./test.ini"
               |> read_whole_file
               |> ParserCombinator.make_input *)
               (* |> ini.run *)
  (* in
  match result with
    | Ok (_, sections) -> sections
                          |> show_sections
                          |> print_endline
    | Error error -> Printf.printf "Error happened at %d: %s"
                                    error.pos
                                    error.desc *)
