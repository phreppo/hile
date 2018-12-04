module Main where

import Lib
-- import Evaluator
-- import Utility
-- import Parser
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        p " if not true or not false and true then skip else skip "
        return ()