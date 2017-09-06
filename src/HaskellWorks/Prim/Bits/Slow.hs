module HaskellWorks.Prim.Bits.Slow
  ( pdep64
  , pdep32
  ) where

import Data.Word

foreign import ccall unsafe "bits.h" slow_pdep64 :: Word64 -> Word64 -> Word64

pdep64 :: Word64 -> Word64 -> Word64
pdep64 = slow_pdep64
{-# INLINE pdep64 #-}

foreign import ccall unsafe "bits.h" slow_pdep32 :: Word32 -> Word32 -> Word32

pdep32 :: Word32 -> Word32 -> Word32
pdep32 = slow_pdep32
{-# INLINE pdep32 #-}
