import Control.Arrow ((>>>))

import Data.Array (Array, array, (!))

import Data.ByteString.Lazy.Char8 (ByteString)
import qualified Data.ByteString.Lazy.Char8 as BS

knapsack :: Array (Int, Int) Int -> (Int, Int) -> Int -> Int -> Int
knapsack _          _ 0 _ = error "Fuckup"
knapsack table (g, v) i h
    | i > 0 && h < g = table ! (i-1, h)
    | otherwise      = max (table ! (i-1, h)) (table ! (i-1, h-g) + v)


parseInt :: ByteString -> Int
parseInt = BS.foldl (\acc c -> acc * 10 + getDigit c) 0
  where
    getDigit :: Char -> Int
    getDigit '0' = 0
    getDigit '1' = 1
    getDigit '2' = 2
    getDigit '3' = 3
    getDigit '4' = 4
    getDigit '5' = 5
    getDigit '6' = 6
    getDigit '7' = 7
    getDigit '8' = 8
    getDigit '9' = 9

tuplefy :: [a] -> (a, a)
tuplefy [x,y] = (x,y)
tuplefy _ = error "Fuckup"

main :: IO ()
main = do
    (s, n):items <-
        (BS.lines >>> map BS.words >>> map (map parseInt) >>> map tuplefy)
        <$> BS.getContents
    print $ solve s n items

solve :: Int -> Int -> [(Int, Int)] -> Int
solve s n items = table ! (n, s)
  where
    table = array ((0,0), (n,s)) $ [ ((0, h), 0) | h <- [0..s] ]
        ++ [ ((i, h), knapsack table item i h)
           | (item, i) <- zip items [1..]
           , h <- [0..s]
           ]