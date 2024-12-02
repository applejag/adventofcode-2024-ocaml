let read_lines input =
  let rec read_lines_rec ic lines =
    try
      let next_line = input_line ic in
      next_line :: read_lines_rec ic lines
    with End_of_file -> lines
  in
  let ic = open_in input in
  try
    let lines = read_lines_rec ic [] in
    close_in ic;
    lines
  with e ->
    close_in_noerr ic;
    raise e

let parse_reports line = String.split_on_char ' ' line |> List.map int_of_string
let parse_input input = read_lines input |> List.map parse_reports

let rec for_all_pairs f v =
  match v with
  | v1 :: v2 :: rest -> (
      match f v1 v2 with true -> for_all_pairs f (v2 :: rest) | false -> false)
  | _ -> true

let is_report_increasing report = for_all_pairs (fun a b -> a < b) report
let is_report_decreasing report = for_all_pairs (fun a b -> a > b) report

let is_report_small_diffs report =
  for_all_pairs (fun a b -> abs (a - b) >= 1 && abs (a - b) <= 3) report

let is_report_safe report =
  (is_report_decreasing report || is_report_increasing report)
  && is_report_small_diffs report

let part1 input =
  let reports = parse_input input in
  Printf.printf "reports count: %d\n" @@ List.length reports;
  List.fold_left
    (fun count report ->
      count + match is_report_safe report with true -> 1 | false -> 0)
    0 reports
  |> Printf.printf "safe reports: %d\n"

let list_without_item items idx_to_remove =
  let rec rec_func remaining idx idx_to_remove =
    match (remaining, idx = idx_to_remove) with
    | _ :: rest, true -> rec_func rest (idx + 1) idx_to_remove
    | _, true -> []
    | head :: rest, false when idx_to_remove > idx ->
        head :: rec_func rest (idx + 1) idx_to_remove
    | _, false -> remaining
  in
  rec_func items 0 idx_to_remove

let one_removed_permutations report =
  match report with
  | [ _ ] -> [ report ]
  | _ -> List.mapi (fun i _ -> list_without_item report i) report

let one_removed_permutations_plus_orig report =
  report :: one_removed_permutations report

let list_any f items = not @@ List.for_all (fun item -> not @@ f item) items

let is_report_safe_or_with_one_removed report =
  list_any is_report_safe @@ one_removed_permutations_plus_orig report

let part2 input =
  let reports = parse_input input in
  Printf.printf "reports count: %d\n" @@ List.length reports;
  List.fold_left
    (fun count report ->
      count
      +
      match is_report_safe_or_with_one_removed report with
      | true -> 1
      | false -> 0)
    0 reports
  |> Printf.printf "safe reports: %d\n"
