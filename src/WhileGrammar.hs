module WhileGrammar
( Stmt (
    Seq, 
    Composition,
    Assign, 
    If, 
    While, 
    Skip), 
  BExpr (..), 
  BBooleanBinOperator (..), 
  BArithmeticBinOperator (..), 
  AExpr (..), 
  AArithemticBinOperator (..), 
)
where

-------------------------------------------------------------------------------
--                                 GRAMMAR
-------------------------------------------------------------------------------

data Stmt = Composition [Stmt]
          | Seq Stmt Stmt
          | Assign String AExpr
          | If BExpr Stmt Stmt
          | While BExpr Stmt
          | Skip
          deriving (Show,Eq)

data BExpr = BoolConst Bool
           | Not BExpr
           | BooleanBinary    BBooleanBinOperator    BExpr BExpr
           | ArithmeticBinary BArithmeticBinOperator AExpr AExpr
           deriving (Show,Eq)

data BBooleanBinOperator = And 
                         | Or
                         deriving (Show,Eq)

data BArithmeticBinOperator = LessEq 
                            | Greater
                            | IsEqual
                            deriving (Show,Eq)

data AExpr = Var      String
           | IntConst Integer
           | Neg      AExpr
           | ABinary  AArithemticBinOperator AExpr AExpr
           deriving (Show,Eq)

data AArithemticBinOperator = Add
                            | Subtract
                            | Multiply
                            deriving (Show,Eq)