module Main where

import Lib
import Parser
import State
import WhilePrograms

program = factorial
s = "[x -> -1]"

main = do
        print_header
        s <-  i (program, s)
        print s

print_header =
        do 
                putStr "S|[\""
                putStr program 
                putStr "\"]| "
                putStrLn s 