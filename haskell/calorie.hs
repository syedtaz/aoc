-- 2022 Day 1

module Main where

import System.Environment (getArgs)
import Data.List (sort)

fmax :: [String] -> [Int] -> Int -> [Int]
fmax [] acc csum
  | csum > 0 = csum : acc
  | otherwise = acc
fmax (x : xs) acc csum
  | x == "" = fmax xs (csum : acc) 0
  | otherwise = fmax xs acc (csum + (read x :: Int))

-- part1 :: [String] -> Int
-- part1 xs = sum $ take 1 $ reverse $ sort $ (fmax xs [] 0)

answer :: [String] -> Int
answer xs = sum $ take 3 $ reverse $ sort $ (fmax xs [] 0)

main :: IO ()
main = do
  args <- getArgs
  content <- readFile (head args)
  print (answer $ lines content)