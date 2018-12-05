module EvalAExpr 
    (eval_aexpr)
where

import System.Random
import WhileGrammar
import State

eval_aexpr :: AExpr -> State -> Integer
eval_aexpr (IntConst n)     s = n 
eval_aexpr (Var identifier) s = assoc_identifier identifier s
eval_aexpr (Neg aexpr)      s = negate $ eval_aexpr aexpr s
eval_aexpr (ABinary operator aexpr1 aexpr2) s = 
    eval_aexpr_operator operator first_partial_value second_partial_value
    where 
        first_partial_value  = eval_aexpr aexpr1 s
        second_partial_value = eval_aexpr aexpr2 s

eval_aexpr_operator :: AArithemticBinOperator -> Integer -> Integer -> Integer
eval_aexpr_operator Add      n1 n2 = n1 + n2
eval_aexpr_operator Subtract n1 n2 = n1 - n2
eval_aexpr_operator Multiply n1 n2 = n1 * n2

assoc_identifier :: String -> State -> Integer

-- problem: we could generate random numbers on the go, but then the function 
-- would become impure, so the choice is between modify the type of the function
-- and fill the initial state with random numbers

-- PRE: state contains one entry with the identifier "identifier"
assoc_identifier identifier (S ((first_identifier,value):entries)) 
    | first_identifier == identifier = value
    | otherwise                      = assoc_identifier identifier (state entries)