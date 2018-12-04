module Main where

import Lib
-- import Evaluator
-- import Utility
-- import Parser
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        p " if 3 = x then ciao := 123 else skip "
        return ()