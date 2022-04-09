type input =
  { text: string;
    pos: int
  }

let input_sub (start: int) (len: int) (s: input): input =
  { text = String.sub (s.text) start len;
    pos = s.pos + start;
  }
let make_input (s: string): input = {text = s; pos = 0}

type error =
  { desc: string;
    pos: int;
  }

type 'a parser = {run : input -> (input * 'a, error) result}

let fail (e: error) = {run = fun _ -> Error e}
let wrap (x: 'a) = {run = fun input -> Ok (input, x)}

let map (f: 'a -> 'b) (p: 'a parser): 'b parser =
  { run =
      fun input ->
        match p.run input with
        | Ok (input', x) -> Ok (input', f x)
        | Error error -> Error error
  }

let bind (f: 'a -> 'b parser) (p: 'a parser): 'b parser =
  { run = fun input ->
      match p.run input with
      | Ok (input', x) -> (f x).run input'
      | Error error -> Error error
  }

(* let prefix (s: string): string parser =
  { run = fun input ->
      let n = String.length s in
      String.sub input. 0 n
  } *)
