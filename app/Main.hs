module Main where

import Lib
import Parser
import State
import WhilePrograms
import Data.Char
import System.IO

program = factorial
s = "[x -> -1]"

-- main = do
--         print_header
--         s <-  i (program, s)
--         print s

main = 
        do
                putStrLn "(W)hile interpreter REPL"
                repl (S [])

print_header =
        do 
                putStr "S|[\""
                putStr program 
                putStr "\"]| "
                putStrLn s 

repl state = 
        do
                putStrLn ""
                putStr "> "
                hFlush stdout
                source <- getLine
                new_state <- interpret source state
                putStrLn $ show new_state
                repl new_state