module EvalTests
    (tests) where

import Test.Tasty
import Test.Tasty.HUnit

import WhileGrammar
import Semantics
import State
import Lib
import WhilePrograms

s1    = state [("x",1), ("y",2), ("z",3)]
empty = state []

build_test program s expected_result = 
    testCase program (compare_impure_states program s expected_result)
    where result = interpret program s

compare_impure_states program s expected_result =
    do
        result <- interpret program s
        assertEqual "" expected_result result


assign1 = build_test "x:=1" empty (state [("x",1)])

assign2 = build_test "x:=300;y:=2" empty (state [("x",300),("y",2)])

skip1 = build_test "skip;skip;skip" s1 s1

skip2 = build_test "skip;x:=2;skip; y:=123" empty (state [("x",2),("y",123)])

if1 = build_test "x:=1; if x=1 then y:=1 else y:=0" empty (state [("x",1),("y",1)])

if2 = build_test "x:=100; if x<=1 then y:=1 else y:=0" empty (state [("y",0),("x",100)])

if3 = build_test "if true and true then x:=1;y:=1 else x:=0;y:=0" empty (state [("y",1),("x",1)])

if4 = build_test "if not true then skip;x:=1;y:=1;skip else skip;x:=0;y:=0;skip" empty (state [("y",0),("x",0)])

wh1 = build_test "x:=0; y:=1; while y<=10 do x := x+1; y := y+1" empty (state [("x",10),("y",11)])

wh2 = build_test "while 0 <= x do x := x-1; skip; z := 3" (state [("x",10),("y",1)]) (state [("x",-1),("y",1),("z",3)])

wh3 = build_test "z := 0; while 0 <= x do x := x-1; skip; z := z+3" (state [("x",10),("y",1)]) (state [("x",-1),("y",1),("z",3*11)])

fact = build_test "y:=1; while not (x = 1) do y := y*x; x := x-1" 
        (state [("x",7)]) 
        (state [("x",1),("y",5040)])

-- f f
or1 = build_test "if 1=0 or 1=0 then th:=1 else el:=1" 
        (state [("th",-1),("el",-1)])
        (state [("th",-1),("el",1)])

-- f t
or2 = build_test "if false or x=1 then th:=1 else el:=1" 
    (state [("x",1),("th",-1),("el",-1)])
    (state [("x",1),("th",1),("el",-1)])

-- t f
or3 = build_test "if true or false then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",1),("el",-1)])

-- t t
or4 = build_test "if not false or th<=1 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",1),("el",-1)])

or5 = build_test "if false or (false or false) or true then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",1),("el",-1)])

greater1 = build_test "if 1 > 0 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",1),("el",-1)])

greater_eq1 = build_test "if 1 >= 1 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",1),("el",-1)])

greater_eq2 = build_test "if 3 >= 1+3 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",-1),("el",1)])

greater2 = build_test "if 1 > 1 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",-1),("el",1)])

less1 = build_test "if 1 < 1 then th:=1 else el:=1" 
    (state [("th",-1),("el",-1)])
    (state [("th",-1),("el",1)])

less2 = build_test "if 1 < x then th:=1 else el:=1" 
    (state [("x",100),("th",-1),("el",-1)])
    (state [("x",100),("th",1),("el",-1)])

composition_sugar1 = build_test "skip; skip; if 0 < 1 then skip else skip"
    (state [])
    (state [])

repeat1 = build_test "skip; x :=0; repeat x:=x+1 until x >= 10"
    (state [])
    (state [("x",10)])

repeat2 = build_test "skip; x :=0; repeat x:=x+1 until x >= -10"
    (state [])
    (state [("x",1)])

repeat3 = build_test "repeat x:=3 until true"
    (state [])
    (state [("x",3)])
    
for1 = build_test "for x:=0 to 9 do skip"
    (state [])
    (state [("x",10)])
    
    
for2 = build_test "base := 2; exponent := 3; accumulator := 1; for i:=1 to exponent do accumulator:=accumulator*base"
    (state [])
    (state [("base",2),("exponent",3),("accumulator",8),("i",4)])

for3 = build_test "y := 0; for x:=3 to 5 do y:=y+1"
    (state [])
    (state [("x",6), ("y",3)])

fib1 = build_test fibonacci
    (state [("x",14)])
    (state [("fn1",377),("fn2",233),("i",15),("x",14),("fn",377)])

tests = [
    assign1,
    assign2,
    skip1,
    skip2,
    if1,
    if2,
    if4,
    wh1,
    wh2,
    wh3,
    fact,
    or1,
    or2,
    or3,
    or4,
    or5,
    greater1,
    greater2,
    less1,
    less2,
    greater_eq1,
    greater_eq2,
    composition_sugar1,
    repeat1,
    repeat2,
    repeat3,
    for1,
    for2,
    for3,
    fib1
    ]