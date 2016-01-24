myAny :: (a -> Bool) -> [a] -> Bool
myAny p = foldl(\a x -> a || p x) False
