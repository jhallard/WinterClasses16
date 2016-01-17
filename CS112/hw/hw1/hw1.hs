-- | Author : John Allard
-- | Date   : Jan 15th 2016
-- | Class  : CMPS 112 UCSC

-- | Homework #1 |--

import Data.Char
import Data.List

-- | 1.) Write a function that turns a first and last name into "$last, $first"
citeAuthor :: String -> String -> String
citeAuthor first last = last ++ ", " ++ first

-- | 2.) Write a function that produces the initials given a first and last name
initials :: String -> String -> String
initials first last = [toUpper (head first) ] ++ "." ++ [toUpper (head last)] ++ "."

-- | 3.) Take an (Author, title, date) tuple and return the title
title :: (String, String, Int) -> String
title (author, title, date) = title

-- | 4.) Take a author, title, date tuple and return a citation-formatted string
citeBook :: (String, String, Int) -> String
citeBook (author, title, date) = title ++ " (" ++ author ++ ", " ++ (show date) ++ ")"

-- | 5.) Write a function that takes a list of citation-tuples and formats them as 
--       the last function did, except putting a newline between each formatted citation
bibliography_rec :: [(String, String, Int)] -> String
bibliography_rec [] = ""
bibliography_rec (x:y) = citeBook x ++ "\n" ++ bibliography_rec y 
    
-- | 6.) Write a function that returns the average publication year from a list of books
averageYear :: [(String, String, Int)] -> Int
averageYear x = sum (map (\(x, y, z) -> z) x) `div`  genericLength x


