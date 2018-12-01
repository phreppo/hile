import ParseWhile
import WhileGrammar

-- main :: IO ()
-- main = putStrLn "Test suite not yet implemented"

import Lib
-- import Semantic
-- import DataStructure
-- import qualified Data.Map as Map

import Test.Tasty
import Test.Tasty.HUnit

import ParserTests

-- import Loops
-- import SemTree

main :: IO ()
main = do
  defaultMain (testGroup "Library tests" tests)
    where
      tests = ParserTests.tests