let parsed_input = read_file("input.txt")
|> to_charlist 
|> split(_, "\n")
|> map(fn(number_char_list) => number_char_list |> concat |> string_to_int, _)
|> split(_, :err)
|> map(fn(group) => map(snd, group), _)
|> map(sum, _)

let part1 = parsed_input 
|> fold(0, max, _) 
|> inspect

let part2 = parsed_input 
|> sort(_, fn(a, b) => b - a) 
|> take(3, _) 
|> sum 
|> inspect
