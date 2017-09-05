module HaskellWorks.Prim.Bits where

import Data.Word

foreign import ccall unsafe "bits.h" pdep64 :: Word64 -> Word64 -> Word64
