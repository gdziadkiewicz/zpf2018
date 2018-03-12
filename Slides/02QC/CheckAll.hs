{-# LANGUAGE TemplateHaskell #-}
import Test.QuickCheck

prop_AddCom3 :: Int -> Int -> Bool  
prop_AddCom3 x y = x + y == y + x

prop_Mul1 :: Int -> Property
prop_Mul1 x = (x>0) ==> (2*x > 0) 
    
return []
runTests = $quickCheckAll

main = runTests
