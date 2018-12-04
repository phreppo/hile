module Main where

import Lib
-- import Evaluator
-- import Utility
-- import Parser
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        p " if not true and not false then skip else skip "
        return ()