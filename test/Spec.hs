import ParseWhile
import WhileGrammar

import Lib

import Test.Tasty
import Test.Tasty.HUnit

import ParserTests
import EvalTests

main :: IO ()
main = do
  defaultMain (testGroup "Library tests" tests)
    where
      tests = ParserTests.tests ++ EvalTests.tests