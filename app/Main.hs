module Main where

import Lib
-- import Evaluator
-- import Utility
-- import Parser
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        p " while 3 >= x and y > 0 do if true then skip else skip;skip "
        -- p " while 3 >= x and y > 0 do if true then skip else skip;skip "
        return ()