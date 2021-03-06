-- | Author : John Allard
-- | Date   : Feb 19th 2016
-- | Class  : CMPS 112 UCSC

-- | I worked alone, no partners to list.

-- | Homework #4 |--
{-# LANGUAGE FlexibleInstances, OverlappingInstances, UndecidableInstances #-}

import Data.Char
import Data.List
import Data.Int
import System.Random

-- | 1. The following skeleton code includes the Gen typeclass for any test 
--      input that can be generated. Anything in the typeclass Random can be 
--      generated using randomIO. However, you still need to make Lists and 
--      Pairs (tuples with two elements) an instance of the Gen type class. 
--      The generated list should have a random length between 0 (empty) and 10 (inclusive).


class (Show a) => Gen a where
  gen :: IO a

instance (Show a, Random a) => Gen a where
  gen = randomIO 

instance (Gen a, Gen b) => Gen (a, b) where
  gen = do 
            x <- gen
            y <- gen
            return (x, y)

instance (Gen a) => Gen [a] where
   gen = do  
            rlen <- gen :: IO Int8
            let len = rlen `mod` 11 -- 0 to 10 baby
            mapM (\_ -> gen) [1..len] -- you don't want to know how many permutations of 
                                      -- gen/IO code I went through before I found something
                                      -- that worked.



-- | 2. As a next step, add the Testable typeclass which will be used to test predicates.
--      These predicates are functions from an arbitary number of arguments to a boolean value.
--
--      You have to complete the missing implementation of the test function, which will generate 
--      a random input and pass it to the function until the resulting boolean value indicates whether 
--      the test predicate holds or not.

{-|  This is my original answer to #2 for use with the quickCheck as described in #3
class Testable a where
test :: a -> IO Bool

instance Testable Bool where
test b = return b

instance (Gen a, Testable b) => Testable (a -> b) where
   test t =  do 
             n <- gen
             test (t n)
|-}

-- | This is the test code for the quickcheck for question #4
class Testable a where
   test :: String -> a -> IO (String, Bool)
 
instance Testable Bool where
   test s b = do
                if b == True
                then return ("", True)
                else return (s, False)
 
instance (Gen a, Testable b) => Testable (a -> b) where
   test s t =  do 
                 n <- gen
                 test (s ++ " " ++ show n) (t n)

 

-- | 3. Finally, implement a quickCheck method. Given a number n and a Testable, it will 
--      perform up to n tests with random inputs, repeated calling test. Once a failing 
--      test was encountered, it will print an error and stop testing.
{-| // commented out to not interfere with #4

quickCheck :: (Testable a) => Int -> a -> IO ()
quickCheck 0 b = do putStr ""
quickCheck n t = do
                  let m = (n-1)
                  ret <- test t
                  if ret then quickCheck m t else putStrLn "Tests Failed"
|-}



-- | 4. In order to improve the test output, quickCheck should also print a string 
--      representation of the counterexample.
--
--      You may have to change the definition of test in order to return a string in addition 
--      to the boolean value. For curried, multi argument functions, the string will include 
--      all arguments in the right order.
quickCheck :: (Testable a) => Int -> a -> IO ()
quickCheck 0 b = do putStr ""
quickCheck n t = do
                  let m = (n-1)
                  (retstr, retbool) <- test "" t
                  if retbool then quickCheck m t else putStrLn ("Failed :" ++ retstr)




-- | 5. The following two sorting algorithms (insertion sort and quick sort) both have a bug
isort :: [Int8] -> [Int8]
isort [] = []
isort (x:xs) = insert (isort xs)
  where insert [] = [x]
        insert (h:t) | x > h = h:insert t
                     | x <= h = h:x:t

qsort :: [Int8] -> [Int8]
qsort [] = []
qsort (x:xs) = qsort [a | a <- xs, a < x] ++ [x] ++ qsort [a | a <- xs, a > x]

-- | Write a comprehensive test for sorting algorithms like qsort and isort which describes 
--   exactly the expected behavior. Using quickCheck with this test should give you a 
--   counterexample for both qsort and isort.
testSort :: ([Int8] -> [Int8]) -> [Int8] -> Bool
isSort [] = True
isSort [x] = True
isSort (x:xs) = (x <= head xs) && (isSort xs)
testSort sort lst = do
                      let res = sort lst
                      (length res == length lst) && (isSort res)

-- | counter example for qsort = [-109,-95,-73,-64,-53,-23,11,103,117]
-- | counter example for isort = [25,-104,126,-127,-12,-71,-47,77,55,71]




-- | 6. Fix the two sorting algorithms above
-- | -- Woohoo I fixed both. Try the following
-- | quickCheck 100 (testSort isortnew)
-- | quickCheck 100 (testSort qsortnew)
isortnew :: [Int8] -> [Int8]
isortnew [] = []
isortnew (x:xs) = insert (isortnew xs)
  where insert [] = [x]
        insert (h:t) | x > h = h:insert t
                     | x <= h = x:h:t

qsortnew :: [Int8] -> [Int8]
qsortnew [] = []
qsortnew (x:xs) = qsortnew [a | a <- xs, a < x] ++ [a | a<-xs, a==x] ++ [x] ++ qsortnew [a | a <- xs, a > x]
