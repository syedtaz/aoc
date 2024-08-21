module Main where

import Data.Text

data Game = Game
  { ident :: Int,
    red :: Int,
    green :: Int,
    blue :: Int
  }

capability :: Game -> Int
capability g
  | red g <= 12 && green g <= 13 && blue g <= 14 = ident g
  | otherwise = 0

power :: Game -> Int
power g = red g * green g * blue g

main :: IO ()
main = return ()