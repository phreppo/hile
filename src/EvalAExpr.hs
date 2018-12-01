module EvalAExpr 
    (eval_aexpr)
where

import System.Random
import WhileGrammar
import State

eval_aexpr :: AExpr -> State -> Integer
eval_aexpr (IntConst n)     state = n 
eval_aexpr (Var identifier) state = assoc_identifier identifier state
eval_aexpr (Neg aexpr)      state = negate $ eval_aexpr aexpr state
eval_aexpr (ABinary operator aexpr1 aexpr2) state = 
    eval_aexpr_operator operator first_partial_value second_partial_value
    where 
        first_partial_value = eval_aexpr aexpr1 state
        second_partial_value = eval_aexpr aexpr2 state

eval_aexpr_operator :: AArithemticBinOperator -> Integer -> Integer -> Integer
eval_aexpr_operator Add      n1 n2 = n1 + n2
eval_aexpr_operator Subtract n1 n2 = n1 - n2
eval_aexpr_operator Multiply n1 n2 = n1 * n2

assoc_identifier :: String -> State -> Integer
-- TODO: return a random number here
assoc_identifier identifier (Def []) = 0
assoc_identifier identifier (Def ((first_identifier,value):entries)) 
    | first_identifier == identifier = value
    | otherwise                      = assoc_identifier identifier (state entries)