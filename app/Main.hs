module Main where

import Data.Monoid ((<>))
import HaskellWorks.Prim.Bits

main :: IO ()
main = do
  let result = pdep64 9 9
  putStrLn $ "Result: " <> show result
