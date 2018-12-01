module EvalBExpr 
    (eval_bexpr)
where

import WhileGrammar
import EvalAExpr
import State

eval_bexpr :: BExpr -> State -> Bool
eval_bexpr (BoolConst b)   state = b
eval_bexpr (Not sub_bexpr) state = not $ eval_bexpr sub_bexpr state
eval_bexpr (BooleanBinary operator subexpr1 subexpr2) state = 
    eval_bexpr_boolean_operator operator subexpr1 subexpr2 state
eval_bexpr (ArithmeticBinary operator subexpr1 subexpr2) state = 
    eval_bexpr_arithemtic_operator operator subexpr1 subexpr2 state

eval_bexpr_boolean_operator :: BBooleanBinOperator -> BExpr -> BExpr -> State -> Bool
eval_bexpr_boolean_operator And subexpr1 subexpr2 state =
    (eval_bexpr subexpr1 state) && (eval_bexpr subexpr2 state) 

eval_bexpr_arithemtic_operator :: BArithmeticBinOperator -> AExpr -> AExpr -> State -> Bool
eval_bexpr_arithemtic_operator LessEq aexpr1 aexpr2 state =
    (eval_aexpr aexpr1 state) <= (eval_aexpr aexpr2 state)
eval_bexpr_arithemtic_operator IsEqual aexpr1 aexpr2 state =
    (eval_aexpr aexpr1 state) == (eval_aexpr aexpr2 state)