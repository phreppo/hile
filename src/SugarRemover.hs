module SugarRemover 
    (
        remove_sugar
    )
where

import WhileGrammar

--------------------------------------------------------------------------------
--  BExpr sugar:
--      - or
--  AExpr sugar:
--          
--  Stmt sugar:
--      
--------------------------------------------------------------------------------

-- a < b == (not (a == b)) and (a <= b)
remove_sugar :: Stmt -> Stmt
remove_sugar (If bexpr stmt1 stmt2) = 
    If (remove_bsugar bexpr) (remove_sugar stmt1) (remove_sugar stmt2)
remove_sugar (While bexpr body) = 
    While (remove_bsugar bexpr) (remove_sugar body)
remove_sugar expr = expr

remove_bsugar :: BExpr -> BExpr

remove_bsugar (BoolConst b) = BoolConst b

remove_bsugar (Not bexpr) = Not (remove_bsugar bexpr)

-- simulate or with AND and NOT: https://en.wikipedia.org/wiki/NAND_logic
remove_bsugar (BooleanBinary Or left right) = 
    make_nand 
        (make_nand sugar_free_left sugar_free_left) 
        (make_nand sugar_free_right sugar_free_right) 
    where sugar_free_left = remove_bsugar left
          sugar_free_right = remove_bsugar right

remove_bsugar (BooleanBinary And left right) = 
    BooleanBinary And sugar_free_left sugar_free_right
    where sugar_free_left = remove_bsugar left
          sugar_free_right = remove_bsugar right
          
remove_bsugar (ArithmeticBinary Greater a1 a2) =
    Not (ArithmeticBinary LessEq sugar_free_a1 sugar_free_a2)
    where sugar_free_a1 = remove_asugar a1
          sugar_free_a2 = remove_asugar a2

remove_bsugar (ArithmeticBinary op a1 a2) =
    ArithmeticBinary op sugar_free_a1 sugar_free_a2
    where sugar_free_a1 = remove_asugar a1
          sugar_free_a2 = remove_asugar a2

make_nand :: BExpr -> BExpr -> BExpr
make_nand bexpr1 bexpr2 =
    Not (BooleanBinary And bexpr1 bexpr2)

remove_asugar :: AExpr -> AExpr
remove_asugar aexpr = aexpr