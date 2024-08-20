module Main where

import Data.Char
import Data.List (isPrefixOf)
import System.Environment (getArgs)

mapping :: [(String, Int)]
mapping =
  [ ("eight", 8),
    ("seven", 7),
    ("three", 3),
    ("zero", 0),
    ("four", 4),
    ("five", 5),
    ("nine", 9),
    ("one", 1),
    ("two", 2),
    ("six", 6)
  ]

rmapping :: [(String, Int)]
rmapping = [(reverse k, v) | (k, v) <- mapping]

prefix :: String -> [(String, Int)] -> Maybe Int
prefix s mapping =
  select $ [Just x | Just x <- map f mapping]
  where
    f (pref, v)
      | pref `isPrefixOf` s = Just v
      | otherwise = Nothing
    select res = case length res of
      0 -> Nothing
      _ -> head res

search :: String -> [(String, Int)] -> Int
search [] _ = 0
search (x : xs) mapping
  | isDigit x = digitToInt x
  | otherwise = case prefix (x : xs) mapping of
      Just v -> v
      Nothing -> search xs mapping

pick :: String -> Int
pick s =
  first * 10 + second
  where
    first = search s mapping
    second = search (reverse s) rmapping

answer :: [String] -> Int
answer xs = sum $ map pick xs

main :: IO ()
main = do
  args <- getArgs
  content <- readFile (head args)
  print $ answer (lines content)
