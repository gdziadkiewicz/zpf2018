import Test.HUnit
import Fib(fib)
import System.Exit
import QuickCheckTests(check)

test1 = TestCase$assertEqual "fib(0) = 0" (fib 0) 0
test2 = TestCase$assertEqual "fib(1) = 1" (fib 1) 1
test3 = TestCase$assertEqual "fib(2) = 1" (fib 2) 1
test4 = TestCase$assertEqual "fib(3) = 2" (fib 3) 2

run = runTestTT tests
tests = TestList [TestLabel "test1" test1, TestLabel "test2" test2,TestLabel "test3" test3, TestLabel "test4" test4]

main :: IO ()
--HUnit fail tests on failed test
-- main = do
--     Counts _ _ _ fails  <- runTestTT tests
--     if fails > 0 then
--         exitFailure
--     else
--         exitSuccess
--Quick check one propery check
-- main = do
--     resut <- quickCheckResult prop_RevRev
--     if isSuccess resut then
--         exitSuccess
--     else
--         exitFailure
main = do
    result <- check
    if result then
        exitSuccess
    else
        exitFailure