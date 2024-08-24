open System

let answer (payload: string) : int =
    let groups = payload.Split("\n\n") in

    let f (s: string) =
        s.Split("\n")
        |> Array.map (fun x -> int x)
        |> Array.sum in

    let sums = Array.map f groups in
    Array.sortDescending sums |> Seq.take 5 |> Seq.sum

printf "%d" (answer (fsi.CommandLineArgs[1]))