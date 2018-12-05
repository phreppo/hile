module Semantics 
    (   
        semantics,
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
semantics (Assign identifier aexpr) = 
    update_state identifier aexpr
semantics Skip = 
    id
semantics (Seq s1 s2) = 
    (semantics s2) . (semantics s1)
semantics (If b s1 s2) =
    cond ((eval_bexpr b), (semantics s1), (semantics s2))
semantics (While b s) = 
    fix f
    where f = \g -> cond (eval_bexpr b, g . semantics s, partial_id )

cond :: (State -> Bool, State -> p, State -> p) -> State -> p
-- cond :: (State -> Bool, State -> Partial State, State -> Partial State) -> State -> Partial State
-- cond :: (State -> Bool, State -> State, State -> State) -> State -> State
cond (p, g1, g2) s
    | p s == True  = g1 s
    | p s == False = g2 s

-- Knaster–Tarski
fix :: ((State -> Partial State) -> State -> Partial State) -> State -> State
fix f = 
    \s -> lub [ apply_times f n bottom | n <- [0..] ] s

apply_times :: ((State -> Partial State) -> (State -> Partial State)) -> 
  Int -> (State -> Partial State) -> State -> Partial State
apply_times f n = 
    foldr (.) id (replicate n f)

lub :: [(State -> Partial State)] -> State -> State
lub (g:gs) s 
    | g s /= Undef = (purify . g) s
    | otherwise    = lub gs s -- lfp found