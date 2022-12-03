let priority = {
    let lowercase = "abcdefghijklmnopqrstuvwxyz" |> to_charlist
    let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> to_charlist

    let lower = lowercase 
    |> enumerate
    |> fold(%{}, fn(acc, (i, ch)) => %{ch => i + 1 | acc}, _)

    uppercase
    |> enumerate
    |> fold(lower, fn(acc, (i, ch)) => %{ch => i + 27 | acc}, _)
}

let chunk(len, ls) = {
    let loop = fn(ls, acc) => match ls
    | [] -> acc
    | _  -> {
        let (next, remaining) = split_at(len, ls)
        loop(remaining, [next | acc])
    }

    loop(ls, [])
}

let common_item([hd | xss]) =
    find(fn(el) => all([find(eq(el, _), other) != () for other in xss]), hd)

let parsed_input = read_file("input.txt") 
|> to_charlist 
|> split(_, "\n") 
|> filter(fn(x) => x != [], _)

let part1 = parsed_input
|> map(fn(ls) => chunk(length(ls) / 2, ls), _)
|> map(common_item, _)
|> map(priority, _)
|> sum
|> inspect

let part2 = parsed_input
|> chunk(3, _)
|> map(common_item, _)
|> map(priority, _)
|> sum
|> inspect
