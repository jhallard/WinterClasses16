-- | Author : John Allard
-- | Date   : Jan 21st 2016
-- | Class  : CMPS 112 UCSC

-- | I worked alone, no partners to list.

-- | Homework #2 |--

import Data.Char
import Data.List

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

-- | 5.) Write a function isUpper which returns true if the provided character 
--       is in the range 'A' to 'Z'.
isUpper1 :: Char -> Bool
isUpper1 x = x `elem` ['A'..'Z'] 

-- | 6.) Using the standard filter, write a function onlyCapitals1 which returns only 
--       the capital letters of the provided string
onlyCapitals1 :: String -> String
onlyCapitals1 str = filter (isUpper) str

-- | 7.) Using list comprehension, write a function which returns only the capital 
--       letters of the provided string. (Using list comprehension)
onlyCapitals2 :: String -> String
onlyCapitals2 str = [x | x <- str, isUpper x]

-- | 8.)
onlyCapitals3 :: String -> String
onlyCapitals3 [] = []
onlyCapitals3 (x:xs) = (if (isUpper x) then [x] else []) ++ onlyCapitals3 xs 

-- | 9.) Write a function which returns a tuple with the quotient and the remainder
--       of an integer division of the provided two numbers
divRemainder :: Int -> Int -> (Int, Int)
divRemainder x y = (x `div` y, x `mod` y)
 
-- | 10.) Write a function which returns the sum of the digits of the given integer
digitSum :: Int -> Int
digitSum x = digitSum' x 0 
            where 
                  digitSum' 0 acc = acc
                  digitSum' x acc = digitSum' (fst (divRemainder x 10)) ((snd (divRemainder x 10)) + acc)
 
-- | 11.) Write a function sayNum which takes a string of digits and spells out the number
--        as a string in english.

-- Note, this was moved to it's own python file called speak.py.
