module Main where

import Criterion.Main
import Data.Bits
import Data.Monoid            ((<>))
import Data.Word
import HaskellWorks.Prim.Bits

import qualified Data.Vector.Storable as DVS

setup :: IO ()
setup = return ()

benchPdep :: [Benchmark]
benchPdep =
  [ env setup $ \bv -> bgroup "bits"
    [ bench "pdep64"    (whnf (pdep64 0) (0 :: Word64))
    , bench "popCount"  (whnf popCount   (0 :: Word64))
    ]
  ]

main :: IO ()
main = defaultMain benchPdep
