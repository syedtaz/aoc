let readlines () =
  let filename = Sys.argv.(1) in
  let handle = In_channel.open_text filename in
  In_channel.input_lines handle

let rec fmax (lst : string list) (acc : int list) (csum : int) = match lst with
  | [] -> if csum > 0 then csum :: acc else acc
  | h :: t -> match h with
    | "" -> fmax t (csum :: acc) 0
    | _ ->
      let value = int_of_string h in
      fmax t acc (csum + value)

let answer lst =
  let result = List.rev @@ List.sort Int.compare (fmax lst [] 0) in
  List.filteri (fun i _ -> i <= 2) result
  |> List.fold_left Int.add 0

let () =
  Format.print_int @@ answer (readlines ())