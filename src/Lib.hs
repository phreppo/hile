module Lib
    ( someFunc,
      pt1
    ) where

import ParseWhile
import Evaluator

someFunc :: IO ()
someFunc = putStrLn "someFunc"

pt1 = parseStringWithList "x:=1"