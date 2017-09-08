module HaskellWorks.Prim.Bits
  ( module X
  ) where

import Data.Word
import HaskellWorks.Prim.Bits.Fast as X

class Pdep a where
  pdep :: a -> a -> a

instance Pdep Word64 where
  pdep = pdep64
  {-# INLINE pdep #-}

instance Pdep Word32 where
  pdep = pdep32
  {-# INLINE pdep #-}

class Pext a where
  pext :: a -> a -> a

instance Pext Word64 where
  pext = pext64
  {-# INLINE pext #-}

instance Pext Word32 where
  pext = pext32
  {-# INLINE pext #-}
