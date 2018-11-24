module SugarRemover 
    (
        remove_sugar
    )
where

import ParseWhile

-- a < b == (not (a == b)) and (a <= b)
remove_sugar :: Stmt -> Stmt
remove_sugar (If bexpr stmt1 stmt2) = 
    If (remove_bsugar bexpr) (remove_sugar stmt1) (remove_sugar stmt2)
remove_sugar (While bexpr body) = 
    While (remove_bsugar bexpr) (remove_sugar body)
remove_sugar expr = expr

-- remove_bsugar (BooleanBinary Or left right) = bexpr
remove_bsugar bexpr = bexpr
