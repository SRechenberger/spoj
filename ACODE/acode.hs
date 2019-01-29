--------------------------------------------------------------------------------
-- Driver ----------------------------------------------------------------------
--------------------------------------------------------------------------------
main :: IO ()
main = do
  str <- getLine
  case str of
    "0" -> pure ()
    xs  -> do
      print $ analyze xs 1 1
      main

--------------------------------------------------------------------------------
-- Algorithm -------------------------------------------------------------------
--------------------------------------------------------------------------------
data Meanings = Zero | One | Two


check :: Char -> Char -> Meanings
check '0'   _ = Zero
check   _ '0' = One
check '1'   x = Two
check '2'   x
  | x > '6'   = Zero
  | otherwise = Two
check   _   _ = Zero


analyze :: String -> Int -> Int -> Int
analyze       []  _ r2 = r2
analyze      [_]  _ r2 = r2
analyze (x:y:xs) r1 r2 = case check x y of
  Zero -> analyze (y:xs) r2 r2
  One  -> analyze (y:xs) r2 r1
  Two  -> analyze (y:xs) r2 (r1 + r2)