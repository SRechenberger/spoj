import Control.Arrow ((>>>), first)

import Data.Word (Word8)

import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as C8


add :: Word8 -> (Word8, Bool)
add w 
    | 48 <= w && w < 57 = (w + 1, False)
    | w == 57 = (48, True)
    | otherwise = error $ show w


addOne :: ByteString -> (ByteString, Bool)
addOne =
    BS.foldr addOne' ([], True)
    >>> (\(bs, c) -> if c then (49:bs, c) else (bs, c))
    >>> first BS.pack
  where
    addOne' word (bs, c)
        | c         = let (word', c') = add word in (word': bs, c')
        | otherwise = (word : bs, c)


leqStr :: ByteString -> ByteString -> Bool
leqStr str1 = leqStr' 0 (BS.length str1) str1
  where
    leqStr' i n str1 str2
        | i >= n = True
        | BS.index str1 (n-i-1) < BS.index str2 i = True
        | BS.index str1 (n-i-1) > BS.index str2 i = False
        | otherwise = leqStr' (i+1) n str1 str2


transform :: ByteString -> ByteString
transform bs = BS.append left'' (BS.reverse right')
  where
    len = BS.length bs
    e = even len
    h = div len 2 + (if e then 0 else 1)
    r = if e then h else h - 1
    left = BS.take h bs
    right = BS.drop r bs
    (left', carry)
        | leqStr left right = addOne left
        | otherwise = (left, False)
    right' = if e then left' else BS.init left'
    left'' = if carry then BS.init left' else left'


main :: IO ()
main = do
    t <- read <$> getLine
    mainLoop t


mainLoop :: Int -> IO ()
mainLoop 0 = pure ()
mainLoop t = do
    BS.getLine >>= (BS.split 13 >>> head >>> transform >>> C8.putStrLn)
    mainLoop (t-1)