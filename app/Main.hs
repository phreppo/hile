module Main where

import Lib
-- import Evaluator
-- import Utility
-- import Parser
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        p " if 3 >= x and y > 0 then skip else skip "
        return ()