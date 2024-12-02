open Adventofcode

let usage_msg = "adventofcode <day>"
let day_arg : int option ref = ref None
let file_flag = ref "input.txt"
let anon_fun day = day_arg := int_of_string_opt day

let speclist =
  [
    ( "--file",
      Arg.Set_string file_flag,
      "Input file inside the inputs/dayXX/ directory" );
  ]

let run_parts day_num part1 part2 =
  let file = Printf.sprintf "inputs/day%02d/%s" day_num !file_flag in
  Printf.printf "=== file: %s\n" file;
  Printf.printf "=== day %02d, part 1:\n" day_num;
  (match part1 with
  | Some f -> f file
  | None -> print_endline "(not implemented)");
  Printf.printf "\n=== day %02d, part 2:\n" day_num;
  match part2 with
  | Some f -> f file
  | None -> print_endline "(not implemented)"

let () =
  Arg.parse speclist anon_fun usage_msg;

  match !day_arg with
  | Some 1 -> run_parts 1 (Some Day01.part1) (Some Day01.part2)
  | Some 2 -> run_parts 2 (Some Day02.part1) None
  | Some n when n <= 25 -> run_parts n None None
  | None ->
      print_endline "missing required argument <day>";
      Arg.usage [] usage_msg;
      exit 1
  | Some day ->
      Printf.printf "invalid day %d\n" day;
      exit 1
