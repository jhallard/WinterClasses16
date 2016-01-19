-- | Author : John Allard
-- | Date   : Jan 15th 2016
-- | Class  : CMPS 112 UCSC

-- | I worked alone, no partners to list.

-- | Homework #1 |--

import Data.Char
import Data.List
import Text.Regex
import Text.Regex.Posix

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
--       ** note ** - this seems like it should return a float or fractional but the assignment
--       required an int so that's what I'm doing
averageYear :: [(String, String, Int)] -> Int
averageYear x = sum (map (\(x, y, z) -> z) x) `div`  genericLength x

-- | 7.) Take the definition of txt given below and write a function 'references'
--       which takes a text with references in the format [n] and returns the total
--       number of references.
txt :: String
txt = "[1] and [2] both feature characters who will do whatever it takes to " ++
      "get to their goal, and in the end the thing they want the most ends " ++
      "up destroying them.  In case of [2] this is a whale..."
references :: String -> Int
references intxt = genericLength (filter (=~"\\[([1-9]+)]") (words intxt))

-- | 8.) Write a function citeText which takes a list of books and a text with references
--       in the form [n] and returns a tet with all references replaces by a citation of the
--       nth book using the citeBook function from problem 5

-- take a "[index_str]" and return cites[index_str]
citeTextHelper :: [(String, String, Int)] -> String -> String
citeTextHelper cites index_str = citeBook (cites !! (index_str =~ "([0-9]+)"))

citeText :: [(String, String, Int)] -> String -> String
citeText cites str = intercalate " " (map (\x -> if (x =~"\\[([1-9]+)]") then citeTextHelper cites x else x) (words str))


