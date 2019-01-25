--import Data.ByteString (ByteString)
--import qualified Data.ByteString as BS

import Data.Array

main = do
    t <- read <$> getLine
    process t
    
process :: Int -> IO ()
process 0 = pure ()
process t = do
    string <- getLine
    print $ lcs string (reverse string)
    process (t-1)
    
lcs xs ys = a ! (0,0) where
  n = length xs
  m = length ys
  a = array ((0,0),(n,m)) $ l1 ++ l2 ++ l3
  l1 = [((i,m),0) | i <- [0..n]]
  l2 = [((n,j),0) | j <- [0..m]]
  l3 = [((i,j), f x y i j) | (x,i) <- zip xs [0..], (y,j) <- zip ys [0..]]
  f x y i j 
    | x == y    = 1 + a ! (i+1,j+1)
    | otherwise = max (a ! (i,j+1)) (a ! (i+1,j))