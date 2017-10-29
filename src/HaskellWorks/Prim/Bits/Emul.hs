module HaskellWorks.Prim.Bits.Emul
  ( pdep32
  , pdep64
  , pext32
  , pext64
  ) where

import Data.Bits
import Data.Int
import Data.Word

pdep64 :: Word64 -> Word64 -> Word64
pdep64 = pdep64' 0

pdep32 :: Word32 -> Word32 -> Word32
pdep32 src mask = fromIntegral (pdep64 (fromIntegral src) (fromIntegral mask))

pdep64' :: Word64 -> Word64 -> Word64 -> Word64
pdep64' result src mask = if lowest /= 0
  then pdep64' (result .|. (lsb .&. lowest)) (src `shiftR` 1) (mask .&. complement lowest)
  else result
  where lowest  = (-mask) .&. mask
        lsb     = fromIntegral ((fromIntegral (src `shiftL` 63) :: Int64) `shiftR` 63)


pext64 :: Word64 -> Word64 -> Word64
pext64 = pext64' 0 0 0

pext32 :: Word32 -> Word32 -> Word32
pext32 src mask = fromIntegral (pext64 (fromIntegral src) (fromIntegral mask))

pext64' :: Word64 -> Int -> Int -> Word64 -> Word64 -> Word64
pext64' result offset index src mask = if index /= 64
  then if maskBit /= 0
          then pext64' (result .|. (srcBit `shiftL` offset)) (offset + 1) (index + 1) src mask
          else pext64'  result                               offset       (index + 1) src mask
  else result
  where srcBit  = (src  `shiftR` index) .&. 1
        maskBit = (mask `shiftR` index) .&. 1
