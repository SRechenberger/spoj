import Control.Arrow ((>>>))
import Data.Vector (Vector, (!))
import qualified Data.Vector as Vector

import Data.Word (Word32)

import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as BS

--------------------------------------------------------------------------------
-- Utils -----------------------------------------------------------------------
--------------------------------------------------------------------------------
readInt :: ByteString -> Int
readInt bs = i
 where
  Just (i, _) = BS.readInt bs

--------------------------------------------------------------------------------
-- Driver ----------------------------------------------------------------------
--------------------------------------------------------------------------------
main :: IO ()
main = do
    coins <- fmap 
        (BS.lines >>> map readInt)
        BS.getContents
    let table = makeTable (maximum coins)
    mapM_ (\i -> print $ table ! i) coins

--------------------------------------------------------------------------------
-- Algorithm -------------------------------------------------------------------
--------------------------------------------------------------------------------
makeTable :: Int -> Vector Word32
makeTable n = table
  where
    table :: Vector Word32
    table = Vector.generate (n+1) f

    f :: Int -> Word32
    f 0 = 0
    f 1 = 1
    f c = max
        (toEnum c)
        (table ! (div c 2) + table ! (div c 3) + table ! (div c 4))