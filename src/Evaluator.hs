module Evaluator 
    (   Entry(..),
        State(..),
        eval,
        interpret,
        )
where

import ParseWhile
import SugarRemover

-------------------------------------------------------------------------------
--                           STATE FUNCTIONS
-------------------------------------------------------------------------------

type Entry = (String, Integer)
data State = Def [Entry] | Undef
           deriving (Show)

interpret :: String -> State -> State
interpret = eval . (remove_sugar . parseString)

eval :: Stmt -> State -> State

eval (Assign identifier aexpr) state 
    | identifier_in_state identifier state = 
        assign_entry_in_state (identifier,evaluated_aexpr) state -- update
    | otherwise = 
        add_entry_to_state (identifier,evaluated_aexpr) state -- new
    where evaluated_aexpr = eval_aexpr aexpr state
    
eval Skip state = id state

eval (Seq first_statement other_statements) state = 
    eval other_statements $ (eval first_statement state)

eval (If condition then_stmt else_stmt) state =
    (cond condition then_stmt else_stmt) state

cond :: BExpr -> Stmt -> Stmt -> State -> State
cond condition then_stmt else_stmt state
    | eval_bexpr condition state = eval then_stmt state
    | otherwise = eval else_stmt state

identifier_in_state :: String -> State -> Bool
identifier_in_state identifier (Def [])  = False
identifier_in_state identifier (Def ((first_identifier,first_value):entries)) = 
    (first_identifier == identifier) || identifier_in_state identifier (Def entries)

add_entry_to_state :: Entry -> State -> State
add_entry_to_state entry (Def entries) = (Def (entry:entries)) 

assign_entry_in_state :: Entry -> State -> State
assign_entry_in_state (identifier,value) (Def entries) =
    Def [ update_entry entry | entry <- entries]
    where update_entry (id,v) = if id == identifier then (identifier,value) else (id,v)

eval_aexpr :: AExpr -> State -> Integer
eval_aexpr (IntConst n)     state = n 
eval_aexpr (Var identifier) state = assoc_identifier identifier state
eval_aexpr (Neg aexpr)      state = negate $ eval_aexpr aexpr state
eval_aexpr (ABinary operator aexpr1 aexpr2) state = 
    eval_aexpr_operator operator first_partial_value second_partial_value
    where 
        first_partial_value = eval_aexpr aexpr1 state
        second_partial_value = eval_aexpr aexpr2 state

assoc_identifier :: String -> State -> Integer
assoc_identifier identifier (Def ((first_identifier,value):entries)) 
    | first_identifier == identifier = value
    | otherwise                      = assoc_identifier identifier (Def entries)

eval_aexpr_operator :: AArithemticBinOperator -> Integer -> Integer -> Integer
eval_aexpr_operator Add      n1 n2 = n1 + n2
eval_aexpr_operator Subtract n1 n2 = n1 - n2
eval_aexpr_operator Multiply n1 n2 = n1 * n2

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