# math is painful
let score1((opponent, self)) = {
    let result_score = match (opponent, self)
    | ("A", "Y") | ("B", "Z") | ("C", "X") -> 6
    | ("A", "Z") | ("B", "X") | ("C", "Y") -> 0
    | _ -> 3

    let move_score = match self
    | "X" -> 1
    | "Y" -> 2
    | "Z" -> 3

    result_score + move_score
}

read_file("input.txt")
|> to_charlist 
|> split(_, "\n")
|> filter(fn(ls) => ls != [], _)
|> map(fn([opponent, _, self]) => (opponent, self), _)
|> map(score1, _)
|> sum
|> inspect

let score2((opponent, strategy)) = {
    let move = match (opponent, strategy)
    | ("A", "X") -> "Z"
    | ("B", "X") -> "X"
    | ("C", "X") -> "Y"
    | ("A", "Z") -> "Y"
    | ("B", "Z") -> "Z"
    | ("C", "Z") -> "X"
    | ("A", "Y") -> "X"
    | ("B", "Y") -> "Y"
    | ("C", "Y") -> "Z"

    score1((opponent, move))
}

read_file("input.txt")
|> to_charlist 
|> split(_, "\n")
|> filter(fn(ls) => ls != [], _)
|> map(fn([opponent, _, self]) => (opponent, self), _)
|> map(score2, _)
|> sum
|> inspect
