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

let () =
  Arg.parse speclist anon_fun usage_msg;

  match !day_arg with
  | Some 1 -> Adventofcode.Day01.part1 ("inputs/day01/" ^ !file_flag)
  | None ->
      print_endline "missing required argument <day>";
      Arg.usage [] usage_msg;
      exit 1
  | Some day ->
      Printf.printf "unknown day %d\n" day;
      exit 1
