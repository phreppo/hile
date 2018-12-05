module Main where

import Lib
import Parser
import State
import WhilePrograms

program = factorial
s = "[x -> 3]"

main = do
        print_header
        s <-  i (program, s)
        print s

print_header =
        do 
                putStrLn "(W)hile Interpreter"
                putStr "S|[\""
                putStr program 
                putStr "\"]| "
                putStrLn s 