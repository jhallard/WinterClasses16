-- | Author : John Allard
-- | Date   : Jan 15th 2016
-- | Class  : CMPS 112 UCSC

-- | Homework #1 |--

import Data.Char

-- | Write a function that turns a first and last name into "$last, $first"
citeAuthor :: String -> String -> String
citeAuthor first last = last ++ ", " ++ first

-- | Write a function that produces the initials given a first and last name
initials :: String -> String -> String
initials first last = [toUpper (head first) ] ++ "." ++ [toUpper (head last)] ++ "."

-- | Take an (Author, title, date) tuple and return the title
title :: (String, String, Int) -> String
title (author, title, date) = title

-- | Take a author, title, date tuple and return a citation-formatted string
citeBook :: (String, String, Int) -> String
citeBook (author, title, date) = title ++ " (" ++ author ++ ", " ++ (show date) ++ ")"

