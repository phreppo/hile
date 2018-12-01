module EvalTests
    (tests) where

import Test.Tasty
import Test.Tasty.HUnit

import ParseWhile
import WhileGrammar
import Evaluator
import State
import Lib

s1    = Def [("x",1), ("y",2), ("z",3)]
empty = Def []

tests = [assign1,assign2]

build_test program state expected_result = 
    testCase program (assertEqual "" expected_result result)
    where result = interpret program state

assign1 = build_test "x:=1" empty (Def [("x",1)])

assign2 = build_test "x:=300;y:=2" empty (Def [("x",300),("y",2)])