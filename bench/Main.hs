module Main where

import Criterion.Main
import Data.Bits
import Data.Monoid            ((<>))
import Data.Word
import HaskellWorks.Prim.Bits

import qualified HaskellWorks.Prim.Bits.Fast as F
import qualified HaskellWorks.Prim.Bits.Slow as S

import qualified Data.Vector.Storable as DVS

setupVector64 :: Int -> IO (DVS.Vector Word64)
setupVector64 n = return $ DVS.fromList (take n (cycle [maxBound, 0]))

setupVector32 :: Int -> IO (DVS.Vector Word32)
setupVector32 n = return $ DVS.fromList (take n (cycle [maxBound, 0]))

setup :: IO ()
setup = return ()

benchPdep64 :: [Benchmark]
benchPdep64 =
  [ env (setupVector64 1) $ \bv -> bgroup "bits"
    [ bench "pdep64"      (whnf (DVS.foldl pdep64 0) bv)
    ]
  , env (setupVector64 1) $ \bv -> bgroup "Fast"
    [ bench "pdep64"      (whnf (DVS.foldl F.pdep64 0) bv)
    ]
  , env (setupVector64 1) $ \bv -> bgroup "Slow"
    [ bench "pdep64"      (whnf (DVS.foldl S.pdep64 0) bv)
    ]
  ]

benchPdep32 :: [Benchmark]
benchPdep32 =
  [ env (setupVector32 1) $ \bv -> bgroup "bits"
    [ bench "pdep32"      (whnf (DVS.foldl pdep32 0) bv)
    ]
  , env (setupVector32 1) $ \bv -> bgroup "Fast"
    [ bench "pdep32"      (whnf (DVS.foldl F.pdep32 0) bv)
    ]
  , env (setupVector32 1) $ \bv -> bgroup "Slow"
    [ bench "pdep32"      (whnf (DVS.foldl S.pdep32 0) bv)
    ]
  ]

main :: IO ()
main = defaultMain (benchPdep64 ++ benchPdep32)
