module AOC.Day1 where

import qualified Data.List as L

example :: String
example =
  unlines
    [ "3   4",
      "4   3",
      "2   5",
      "1   3",
      "3   9",
      "3   3"
    ]

---- part 1
p1 :: String -> Integer
p1 input =
  let xs = map (map read . words) (lines input) :: [[Integer]]
      first = L.sort $ head <$> xs
      second = L.sort $ (!! 1) <$> xs
      diffs = zipWith (\a b -> abs (a - b)) first second
   in sum diffs

part1 :: FilePath -> IO ()
part1 fp = do
  input <- readFile fp
  print (p1 input)

---- part 2

genMap :: [Integer] -> [(Integer, Integer)] -> [(Integer, Integer)]
genMap [] m = m
genMap (x : xs) m = case lookup x m of
  (Just n) -> genMap xs ((x, n + 1) : m)
  Nothing -> genMap xs ((x, 1) : m)

sumUp :: [Integer] -> [(Integer, Integer)] -> Integer
sumUp [] _ = 0
sumUp (x : xs) m = case lookup x m of
  (Just n) -> x * n + sumUp xs m
  Nothing -> sumUp xs m

p2 :: String -> Integer
p2 input =
  let xs = map (map read . words) (lines input) :: [[Integer]]
      first = L.sort $ head <$> xs
      second = L.sort $ (!! 1) <$> xs
      occurMap = genMap second []
   in sumUp first occurMap

part2 :: FilePath -> IO ()
part2 p = do
  input <- readFile p
  print $ p2 input
