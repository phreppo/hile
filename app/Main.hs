module Main where

import Lib
import Parser

main :: IO ()
main = do
        putStrLn "ciao"
        (print . parse) " while 3 >= x and y > 0 do if true then skip else skip;skip "
        -- p " while 3 >= x and y > 0 do if true then skip else skip;skip "
        return ()