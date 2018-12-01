module Evaluator 
    (   
        eval,
    )
where

import State
import WhileGrammar
import SugarRemover
import EvalAExpr
import EvalBExpr
import UpdateState

-------------------------------------------------------------------------------
--                            SEMANTIC FUNCTION
-------------------------------------------------------------------------------

eval :: Stmt -> State -> State

eval (Assign identifier aexpr) = update_state identifier aexpr
    
eval Skip = id

eval (Seq s1 s2) = 
    (eval s2) . (eval s1)

eval (If b s1 s2) =
    cond ((eval_bexpr b), (eval s1), (eval s2))

eval (While b s) = fix f
    where f = \g -> cond (eval_bexpr b, g . eval s, id)

fix :: ((State -> State) -> (State -> State)) -> State -> State
fix f = lub [ fnth f n bottom | n <- [0..] ] 

fnth :: 
  ((State -> State) -> (State -> State)) -> 
  Int -> 
  (State -> State) ->
  State -> State
fnth f 0 = id
fnth f n = f . (fnth f (n-1))
  
lub :: [(State -> State)] -> State -> State
lub (g:gs) s 
    | (g s) /= Undef = g s -- if exist g (and g s) is unique, also g is the least
    | otherwise = lub gs s
  
cond :: (State -> Bool, State -> State, State -> State) -> State -> State
cond (p, g1, g2) s
  | p s == True  = g1 s
  | p s == False = g2 s