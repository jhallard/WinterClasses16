-- | Author : John Allard
-- | Date   : Jan 21st 2016
-- | Class  : CMPS 112 UCSC

-- | I worked alone, no partners to list.

-- | Homework #2 |--

import Data.Char
import Data.List
import Text.Regex
import Text.Regex.Posix

-- | 1.) Using recursion, write a function myFoldl following the type below that 
--       behaves like the standard foldl
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl op a [] = a
myFoldl op a (x:xs) = op (myFoldl op a xs) x

-- | 2.) Using the standard foldl, write a function myReverse (type given below) 
--       which behaves like the standard reverse 
myReverse :: [a] -> [a]
myReverse = myFoldl (flip (:)) []

-- ** Grading Note ** I had to consult outside material for help with the next
-- two problems, I used this page to help me understand the relationship 
-- between folds and recursion, and how this allows one to turn a foldl -> foldr
-- and visa versa. http://www.cs.nott.ac.uk/~pszgmh/fold.pdf
--
-- | 3.) Using the standard foldl (not myFoldl), write a function which behaves 
--       just like the standard foldr.
myFoldr :: (b -> a -> a) -> a -> [b] -> a
myFoldr op acc xs = foldl (\a b c -> a (op b c)) id xs acc

-- | 4.) Using the standard foldr (not myFoldr), write a function myFold2 
--       which behaves just like the standard foldl.
myFoldl2 :: (a -> b -> a) -> a -> [b] -> a
myFoldl2 op acc xs = foldr (\a b c -> b (op c a)) id xs acc


