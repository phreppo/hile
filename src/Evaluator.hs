module Evaluator 
    (   
        semantics,
        -- TODO: remove these
        fix,fnth,lub,cond
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

semantics :: Stmt -> State -> State
semantics (Assign identifier aexpr) = update_state identifier aexpr
semantics Skip = id
semantics (Seq s1 s2) = 
    (semantics s2) . (semantics s1)
semantics (If b s1 s2) =
    cond ((eval_bexpr b), (semantics s1), (semantics s2))
semantics (While b s) = fix f
    where f = \g -> cond (eval_bexpr b, g . semantics s, id)

cond :: (State -> Bool, State -> State, State -> State) -> State -> State
cond (p, g1, g2) s
    | p s == True  = g1 s
    | p s == False = g2 s

-- Knaster–Tarski

fix :: ((State -> State) -> (State -> State)) -> State -> State
fix f = lub [ fnth f n bottom  | n <- [0..] ] 

fnth :: ((State -> State) -> (State -> State)) -> Int -> (State -> State) -> State -> State
fnth f n = (foldr (.) id (replicate n f))
  
lub :: [(State -> State)] -> State -> State
lub (f:fs) s 
    -- TODO: remove comment
    | s' /= Undef = s' -- if exist g (and g s) is unique, also g is the least
    | otherwise   = lub fs s
    where s' = f s