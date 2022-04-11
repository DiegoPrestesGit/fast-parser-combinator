open ParserCombinator

type key = string
type value_t = string
type pair_t = key * value_t
type section = {
  name: string;
  pairs: pair_t list;
}

let show_pair ((key, value_t): pair_t): string = Printf.sprintf "(%s, %s)" key value_t

let show_pairs (pairs: pair_t list): string =
  pairs
  |> List.map show_pair
  |> String.concat ","
  |> Printf.sprintf "[%s]"

let show_section (sec: section): string =
  Printf.sprintf "{name = %s; pairs = %s}" sec.name (show_pairs sec.pairs)

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

let section_name: string parser =
  prefix "[" *> parse_while (fun x -> x != ']') <* prefix "]"

let  is_space (x: char) = x == ' ' || x == '\n'

let comments: string parser = prefix ";" *> parse_while (fun x -> x != '\n')

let white_spaces: string parser =
  parse_while is_space

let pair: pair_t parser =
  let name = parse_while (fun x -> not (is_space x) && x != '=') in
  (white_spaces *> name <* white_spaces <* prefix "=" <* white_spaces) <*> (name <* white_spaces)

let section: section parser =
  section_name <*> many pair
  |> map (fun (s, ps) -> {name = s; pairs = ps})

let ini: section list parser =
  many section

let () =
  match Sys.argv |> Array.to_list with
  | _ :: file_path :: _ ->
    let result = file_path
    |> read_whole_file
    |> make_input
    |> ini.run
  in
    (match result with
    | Ok (_, sections) -> sections |> show_sections |> print_endline
    | Error error -> Printf.printf "Error during parsing at position %d: %s" error.pos error.desc)
  | _ -> failwith "expected path to an ini file"
