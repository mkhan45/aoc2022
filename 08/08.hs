import Data.List (transpose)
import Data.List.Split (splitOn)
import Data.Char (digitToInt)

import qualified Data.Set as Set

(|>) = flip ($)

countTrees' :: [Int] -> [Int]
countTrees' ls = countTrees'' (-1) (zip ls [0..])
    where countTrees'' _ [] = []
          countTrees'' max ((h, i) : rest)
            | h > max = i : countTrees'' h rest
            | otherwise = countTrees'' max rest

countTrees grid =
    let rows = grid
        cols = transpose grid
        numRows = length rows
        numCols = length cols
        seenLR' = map countTrees' rows
        seenRL' = map countTrees' (rows |> map reverse)
        seenTB' = map countTrees' cols
        seenBT' = map countTrees' (cols |> map reverse)
        seenLR  = zip [0..] seenLR' |> map (\(i, x) -> zip (repeat i) x)
        seenRL  = zip [0..] seenRL' |> map (\(i, x) -> zip (repeat i) (map (numCols-1-) x))
        seenTB  = zip [0..] seenTB' |> map (\(i, x) -> zip x (repeat i))
        seenBT  = zip [0..] seenBT' |> map (\(i, x) -> zip (map (numRows-1-) x) (repeat i))
     in Set.size $ Set.fromList $ concat $ concat [seenLR, seenRL, seenTB, seenBT]

main = do
    inp <- readFile "input.txt"
    let grid = splitOn "\n" inp |> filter (/="") |> map (map digitToInt) :: [[Int]]
    print $ countTrees grid
