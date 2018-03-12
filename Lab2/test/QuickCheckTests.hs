{-# LANGUAGE TemplateHaskell #-}

module QuickCheckTests where
import Data.List
import Test.QuickCheck

instance Show(a->b) where
  show _ = "<function>"

--Test props
prop_a = 1 == 1
prop_RevRev xs = reverse (reverse xs) == xs
--  where types = xs::[Int]
prop_RevRev2 xs = reverse (reverse xs) == xs
--  where types = xs::[Int]
prop_RevRev3 xs = reverse (reverse xs) == xs
--  where types = xs::[Int]

-- sort []
prop_sort1 xs = sort (sort xs) == sort xs
prop_sort2 xs n = n>0 && n < ((product . flip take [1..]) (length xs)) ==> sort (permutations xs !! n) == sort xs
prop_plusplus1 xs = xs ++ [] == xs
prop_plusplus2 xs = [] ++ xs == xs
prop_plusplus3 xs ys = xs /= [] && ys /= [] && xs /= ys ==>  xs ++ ys /= ys ++ xs
prop_map1 f = map f [] == []
prop_map2 xs = map id xs == xs
prop_map3 f xs = map f xs == reverse (map f (reverse xs))


return []
--quickCheckAll dla polimorficzny defaultuje do inta
check = $quickCheckAll