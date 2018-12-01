module Lib
    (printEvalLoop) where

import ParseWhile
import WhileGrammar
import Evaluator
import Utility

printEvalLoop = 
    printEvalLoopRec (Def [])

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