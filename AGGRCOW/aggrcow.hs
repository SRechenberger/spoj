import Control.Arrow ((>>>))
import Control.Monad (forM)
import Data.List (sort)

import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as BS

--------------------------------------------------------------------------------
-- Utils -----------------------------------------------------------------------
--------------------------------------------------------------------------------
readInt :: ByteString -> Int
readInt bs = i
 where
  Just (i, _) = BS.readInt bs


read2Int :: ByteString -> (Int, Int)
read2Int bs = (i, j)
 where
  Just (i, bs') = BS.readInt bs
  Just (j, _)   = BS.readInt (BS.tail bs')


foldr1' :: (a -> acc -> acc) -> (a -> acc) -> [a] -> acc
foldr1' op init (a:as) = foldr op (init a) as

--------------------------------------------------------------------------------
-- Driver ----------------------------------------------------------------------
--------------------------------------------------------------------------------
main :: IO ()
main = do
  t <- readInt <$> BS.getLine
  cases t


cases :: Int -> IO ()
cases 0 = pure ()
cases t = do
  (n, cows) <- read2Int <$> BS.getLine
  (stables, left, right) <- readStables n
  print $ searchMinDist (sort stables) cows left right (-1)
  cases (t-1)


readStables :: Int -> IO ([Int], Int, Int)
readStables t = (\is -> let (l, r) = minmax is in (is, l, r)) <$> stables
 where
  minmax :: [Int] -> (Int, Int)
  minmax = foldr1' (\i (l, r) -> (min i l, max i r)) (\i -> (i, i))

  stables :: IO [Int]
  stables = forM [1..t] (const $ readInt <$> BS.getLine)

--------------------------------------------------------------------------------
-- Algorithm -------------------------------------------------------------------
--------------------------------------------------------------------------------
feasable :: [Int] -> Int -> Int -> Bool
feasable (x:xs) d k = feasable' xs x d (k-1) 


feasable' :: [Int] -> Int -> Int -> Int -> Bool
feasable' _      _ _ 0 = True
feasable' []     _ _ _ = False
feasable' (x:xs) p d k
  | x - p >= d = feasable' xs x d (k-1)
  | otherwise  = feasable' xs p d k


searchMinDist :: [Int] -> Int -> Int -> Int -> Int -> Int
searchMinDist stables cows left right acc
  | left >= right = acc
  | feasable stables mid cows =
      searchMinDist stables cows (mid+1) right (max acc mid)
  | otherwise =
      searchMinDist stables cows left mid acc
 where
  mid = (right + left) `div` 2