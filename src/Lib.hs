module Lib
    (interpret, 
     printEvalLoop,get_identifiers_in_stmt
    ) 
where

import State
import ParseWhile
import WhileGrammar
import Evaluator
import Utility
import SugarRemover

e program = interpret program example_state

example_state = state [("x",3),("y",1)]

interpret :: String -> State -> State
interpret = eval . remove_sugar . parseString

-- fill_state :: State -> Stmt -> State
-- fill_state s ast = Undef

get_identifiers_in_stmt :: Stmt -> [String]
get_identifiers_in_stmt (Seq s1 s2) =
    (get_identifiers_in_stmt s1) ++ (get_identifiers_in_stmt s2)
get_identifiers_in_stmt (Assign identifier aexpr) =
    [identifier] ++ get_identifiers_in_aexpr aexpr
get_identifiers_in_stmt (If bexpr then_stmt else_stmt) =
    (get_identifiers_in_bexpr bexpr) ++ 
    (get_identifiers_in_stmt then_stmt) ++
    (get_identifiers_in_stmt else_stmt)
get_identifiers_in_stmt (While bexpr body) = 
    (get_identifiers_in_bexpr bexpr) ++ 
    (get_identifiers_in_stmt body)
get_identifiers_in_stmt (Skip) = []

get_identifiers_in_aexpr :: AExpr -> [String] 
get_identifiers_in_aexpr (Var identifier) = [identifier]
get_identifiers_in_aexpr (Neg aexpr) = get_identifiers_in_aexpr aexpr
get_identifiers_in_aexpr (ABinary _ aexpr1 aexpr2) = 
    (get_identifiers_in_aexpr aexpr1) ++ (get_identifiers_in_aexpr aexpr2)
get_identifiers_in_aexpr _ = []

get_identifiers_in_bexpr :: BExpr -> [String]
get_identifiers_in_bexpr (Not bexpr) = get_identifiers_in_bexpr bexpr 
get_identifiers_in_bexpr (BooleanBinary _ bexpr1 bexpr2) = 
    (get_identifiers_in_bexpr bexpr1) ++ (get_identifiers_in_bexpr bexpr2)
get_identifiers_in_bexpr (ArithmeticBinary _ aexpr1 aexpr2) = 
    (get_identifiers_in_aexpr aexpr1) ++ (get_identifiers_in_aexpr aexpr2)
get_identifiers_in_bexpr _ = [] 


printEvalLoop = 
    printEvalLoopRec (state [])

printEvalLoopRec state = 
    do 
        putStr "> "
        program <- getLine
        if program == "exit"
            then return ()
            else
                evalAndLoop program state

evalAndLoop program state = 
    do
        putStrLn ""
        putStrLn $ show (interpret program state)
        putStrLn ""
        printEvalLoopRec (interpret program state)