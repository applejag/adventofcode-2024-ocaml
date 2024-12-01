let rec read_lines_rec ic lines =
  try
    let next_line = input_line ic in
    next_line :: read_lines_rec ic lines
  with End_of_file -> lines

let read_lines input =
  let ic = open_in input in
  try
    let lines = read_lines_rec ic [] in
    close_in ic;
    lines
  with e ->
    close_in_noerr ic;
    raise e

let split_line line =
  let first_len = String.index line ' ' in
  let second_idx = first_len + 3 in
  let remaining_len = String.length line - second_idx in
  ( String.sub line 0 first_len |> int_of_string,
    String.sub line second_idx remaining_len |> int_of_string )

let rec parse_lines_rec lines first_list second_list =
  match lines with
  | line :: rest ->
      let first, second = split_line line in
      parse_lines_rec rest (first :: first_list) (second :: second_list)
  | [] -> (first_list, second_list)

let parse_lines lines = parse_lines_rec lines [] []

let part1 input =
  let first_list, second_list = parse_lines @@ read_lines input in
  List.map2
    (fun a b -> abs @@ (a - b))
    (List.sort compare first_list)
    (List.sort compare second_list)
  |> List.fold_left ( + ) 0 |> Printf.printf "sum: %d\n"

let part2 input =
  let first_list, second_list = parse_lines @@ read_lines input in
  let counts_per_num =
    Array.init
      (List.fold_left2
         (fun acc a b -> max acc @@ max a b)
         0 first_list second_list
      + 1)
      (fun _ -> ref 0)
  in
  Printf.printf "array len: %d\n" @@ Array.length counts_per_num;
  List.iter (fun n -> incr @@ Array.get counts_per_num n) second_list;
  first_list
  |> List.map (fun n -> n * !(Array.get counts_per_num n))
  |> List.fold_left ( + ) 0 |> Printf.printf "sum: %d\n"
