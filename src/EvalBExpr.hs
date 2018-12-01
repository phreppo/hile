module EvalBExpr 
    (eval_bexpr)
where

import WhileGrammar
import EvalAExpr
import State

eval_bexpr :: BExpr -> State -> Bool
eval_bexpr (BoolConst b)   s = b
eval_bexpr (Not sub_bexpr) s = not $ eval_bexpr sub_bexpr s
eval_bexpr (BooleanBinary operator subexpr1 subexpr2) s = 
    eval_bexpr_boolean_operator operator subexpr1 subexpr2 s
eval_bexpr (ArithmeticBinary operator subexpr1 subexpr2) s = 
    eval_bexpr_arithemtic_operator operator subexpr1 subexpr2 s

eval_bexpr_boolean_operator :: BBooleanBinOperator -> BExpr -> BExpr -> State -> Bool
eval_bexpr_boolean_operator And subexpr1 subexpr2 s =
    (eval_bexpr subexpr1 s) && (eval_bexpr subexpr2 s) 

eval_bexpr_arithemtic_operator :: BArithmeticBinOperator -> AExpr -> AExpr -> State -> Bool
eval_bexpr_arithemtic_operator LessEq aexpr1 aexpr2 s =
    (eval_aexpr aexpr1 s) <= (eval_aexpr aexpr2 s)
eval_bexpr_arithemtic_operator IsEqual aexpr1 aexpr2 s =
    (eval_aexpr aexpr1 s) == (eval_aexpr aexpr2 s)