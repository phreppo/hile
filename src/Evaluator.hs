module Evaluator 
    (   Entry(..),
        State(..),
        eval,
        -- interpret,
        )
where

import State
import WhileGrammar
import SugarRemover
import EvalAExpr
import EvalBExpr

-------------------------------------------------------------------------------
--                            SEMANTIC FUNCTION
-------------------------------------------------------------------------------

eval :: Stmt -> State -> State

eval (Assign identifier aexpr) = update_state identifier aexpr
    
eval Skip = id

eval (Seq first_statement other_statements) = 
    (eval other_statements) . (eval first_statement)

eval (If condition then_stmt else_stmt) =
    cond ((eval_bexpr condition), (eval then_stmt), (eval else_stmt))

-- eval (While condition body) = fix f
--     where f = \g -> cond condition (g . (eval body)) id

-- fix f = lub [ fnth f n bottom | n <- [0..] ] -- Theorem 4.37

-- fnth f 0 = id
-- fnth f n = f . (fnth f (n-1))
  
-- lub (g:gs) s -- Lemma 4.25
--     | g s /= Undef = g s -- if exist g (and g s) is unique, also g is the least
--     | otherwise = lub gs s
  
cond :: (State -> Bool, State -> State, State -> State) -> State -> State
cond (p, g1, g2) s
  | p s == True  = g1 s
  | p s == False = g2 s

update_state :: String -> AExpr -> State -> State
update_state identifier aexpr state      
        | identifier_in_state identifier state = 
            assign_entry_in_state (identifier,evaluated_aexpr) state -- update
        | otherwise = 
            add_entry_to_state (identifier,evaluated_aexpr) state -- new
        where evaluated_aexpr = eval_aexpr aexpr state

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