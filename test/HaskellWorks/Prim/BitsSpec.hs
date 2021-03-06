module HaskellWorks.Prim.BitsSpec (spec) where

import HaskellWorks.Hspec.Hedgehog
import Hedgehog
import Test.Hspec

import qualified HaskellWorks.Prim.Bits.Emul as E
import qualified HaskellWorks.Prim.Bits.Fast as F
import qualified HaskellWorks.Prim.Bits.Slow as S
import qualified Hedgehog.Gen                as G
import qualified Hedgehog.Range              as R

{- HLINT ignore "Redundant do"        -}
{- HLINT ignore "Reduce duplication"  -}

spec :: Spec
spec = describe "HaskellWorks.Prim.BitsSpec" $ do
  it "pdep64 behaves the same" $ require $ property $ do
    a <- forAll $ G.word64 R.constantBounded
    b <- forAll $ G.word64 R.constantBounded
    E.pdep64 a b === S.pdep64 a b
  it "pdep32 behaves the same" $ require $ property $ do
    a <- forAll $ G.word32 R.constantBounded
    b <- forAll $ G.word32 R.constantBounded
    E.pdep32 a b === S.pdep32 a b
  it "pext64 behaves the same" $ require $ property $ do
    a <- forAll $ G.word64 R.constantBounded
    b <- forAll $ G.word64 R.constantBounded
    E.pext64 a b === S.pext64 a b
  it "pext32 behaves the same" $ require $ property $ do
    a <- forAll $ G.word32 R.constantBounded
    b <- forAll $ G.word32 R.constantBounded
    E.pext32 a b === S.pext32 a b
