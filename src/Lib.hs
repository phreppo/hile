module Lib
    (interpret, 
     printEvalLoop
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