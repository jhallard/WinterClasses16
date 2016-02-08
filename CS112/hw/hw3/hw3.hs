-- | Author : John Allard
-- | Date   : Feb 5th 2016
-- | Class  : CMPS 112 UCSC

-- | I worked alone, no partners to list.

-- | Homework #3 |--

import Data.Char
import Data.List

-- | 1. Suppose we have the following type of binary search trees with 
--   keys of type k and values of type v:
data BST k v = Empty |
               Node k v (BST k v) (BST k v)
-- | Write a val function that returns Just the stored value at the 
--   root node of the tree. If the tree is empty, val returns Nothing.
val :: BST k v -> Maybe v
val Empty =  Nothing
val (Node key val lbst rbst) = Just val

-- | 2. Write a size function that returns the number of nodes in the tree.
size :: BST k v -> Int
size Empty = 0
size (Node key val lbst rbst) = 1 + (size lbst) + (size rbst)

-- | 3. Write an ins function that inserts a value v using k as key. If the 
--      key is already used in the tree, it just updates the value, otherwise 
--      it will add a new node while maintaining the order of the binary search tree.
ins :: (Ord k) => k -> v -> BST k v -> BST k v
ins key val Empty = (Node key val (Empty) (Empty))
ins key val (Node k v lbst rbst) = if key < k
                                   then Node k v (ins key val (lbst)) rbst
                                   else Node k v lbst (ins key val (rbst))

-- | 4. Make BST an instance of the Show type class. You will have to implement the 
--      show function such that the result every node of the tree is shown as "(leftTree value rightTree)".
instance (Show v) => Show (BST k v) where
  show Empty = ""
  show (Node k v left right) = "(" ++ show left ++ " " ++ show v ++ " " ++ show right ++ ")"

-- | 5. Suppose we had the following datatype
data JSON = JStr String
            | JNum Double
            | JArr [JSON]
            | JObj [(String, JSON)]

-- | make JSON an instance of the Show type class. You will have to implement the show function such that the
--   output looks like normal JSON.
instance Show JSON where
    show (JStr s) = show s
    show (JNum d) = show d
    show (JArr a) = "[" ++ intercalate ", " (map show a)  ++ "]"
    show (JObj lst) = "{" ++ intercalate ", " (map (\x -> show (fst x) ++ ":" ++ show (snd x)) lst) ++ "}"
