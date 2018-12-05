module ParserTests
    (tests) where

import Test.Tasty
import Test.Tasty.HUnit

import Parser
import WhileGrammar


tests = [numericAssign,genericAssign,skip,seq1,seq2,simpleIf, composedIf,composedIf2,simpleWhile]

numericAssign = testCase "[:=] numeric" (assertEqual "" expected result)
        where expected = parse "x:=1"
              result = Assign "x" (IntConst 1)

genericAssign = testCase "[:=] generic" (assertEqual "" expected result)
        where expected = parse "x:=y+x*2"
              result = Assign "x" (ABinary Add (Var "y") (ABinary Multiply (Var "x") (IntConst 2)))

skip = testCase "[skip] skip" (assertEqual "" expected result)
    where expected = parse "skip"
          result = Skip

seq1 = testCase "[;] simple seq" (assertEqual "" expected result)
    where expected = parse "x:=1; skip"
          result = Seq (Assign "x" (IntConst 1)) (Skip)

seq2 = testCase "[;] double seq" (assertEqual "" expected result)
    where expected = parse "x:=1; y:=1; skip"
          result = Seq (Assign "x" (IntConst 1)) (Seq (Assign "y" (IntConst 1)) (Skip))

simpleIf = testCase "[if] simple if" (assertEqual "" expected result)
        where expected = parse "if 1=1 then skip else skip"
              result = If (ArithmeticBinary IsEqual (IntConst 1) (IntConst 1)) Skip Skip


composedIf = testCase "[if] composed if" (assertEqual "" expected result)
    where expected = parse "if 1=1 then skip else x:=1;y:=2"
          result = If (ArithmeticBinary IsEqual (IntConst 1) (IntConst 1)) Skip (Seq (Assign "x" (IntConst 1)) (Assign "y" (IntConst 2)))

composedIf2 = testCase "[if] composed if 2" (assertEqual "" expected result)
    where expected = parse "if 1=1 then x:=1;y:=2 else x:=1;y:=2"
          result = If (ArithmeticBinary IsEqual (IntConst 1) (IntConst 1)) (Seq (Assign "x" (IntConst 1)) (Assign "y" (IntConst 2))) (Seq (Assign "x" (IntConst 1)) (Assign "y" (IntConst 2)))

simpleWhile = testCase "[wh] simple while" (assertEqual "" expected result)
    where expected = parse "while x<=1 do skip"
          result = While (ArithmeticBinary LessEq (Var "x") (IntConst 1)) Skip