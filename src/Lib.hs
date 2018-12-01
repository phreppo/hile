module Lib
    (interpret, 
     get_identifiers_in_stmt,
     get_random_values,
     get_random_integer,
     update_entries
    ) 
where

import System.Random
import Control.Monad (replicateM)
    
import State
import ParseWhile
import WhileGrammar
import Evaluator
import Utility
import SugarRemover
import UpdateState

e program = interpret program example_state
example_state = state [("x",3),("y",1)]

-- interpret :: String -> State -> State
-- interpret = eval . remove_sugar . parseString

-- initialize_state abstract_syntax_tree = 
--     state [ (identifier, unsafeLocalState (randomIO :: IO Integer)) | identifier <- (get_identifiers_in_stmt abstract_syntax_tree) ]

-- i :: String -> 
interpret :: String -> State -> IO State
interpret source_program s =
    do
        values <- get_random_values (length identifiers)
        return $ ( eval . remove_sugar ) abstract_syntax_tree 
            (update_entries (state [entry | entry <- zip identifiers values]) s)
    where abstract_syntax_tree = parseString source_program
          identifiers = get_identifiers_in_stmt abstract_syntax_tree

update_entries :: State -> State -> State          
-- takes the first state and overwrites values of the second on it
update_entries first_state (Def []) = first_state
update_entries first_state (Def (first_entry:other_entries)) =
    update_entries (overwrite_entry first_entry first_state) (state other_entries)

get_random_values :: Int -> IO [Integer]
get_random_values n = replicateM n (get_random_integer)

get_random_integer = randomIO :: IO Integer

get_identifiers_in_stmt :: Stmt -> [String]
get_identifiers_in_stmt stmt =
    (remove_duplicates . get_identifiers_in_stmt_with_duplicate) stmt

remove_duplicates :: (Eq a) => [a] -> [a]
remove_duplicates list = rem_dups list []

rem_dups :: (Eq a) => [a] -> [a] -> [a]
rem_dups [] _ = []
rem_dups (x:xs) list2
    | (x `elem` list2) = rem_dups xs list2
    | otherwise = x : rem_dups xs (x:list2)

get_identifiers_in_stmt_with_duplicate :: Stmt -> [String]
get_identifiers_in_stmt_with_duplicate (Seq s1 s2) =
    (get_identifiers_in_stmt_with_duplicate s1) ++ (get_identifiers_in_stmt_with_duplicate s2)
get_identifiers_in_stmt_with_duplicate (Assign identifier aexpr) =
    [identifier] ++ get_identifiers_in_aexpr aexpr
get_identifiers_in_stmt_with_duplicate (If bexpr then_stmt else_stmt) =
    (get_identifiers_in_bexpr bexpr) ++ 
    (get_identifiers_in_stmt_with_duplicate then_stmt) ++
    (get_identifiers_in_stmt_with_duplicate else_stmt)
get_identifiers_in_stmt_with_duplicate (While bexpr body) = 
    (get_identifiers_in_bexpr bexpr) ++ 
    (get_identifiers_in_stmt_with_duplicate body)
get_identifiers_in_stmt_with_duplicate (Skip) = []

get_identifiers_in_aexpr :: AExpr -> [String] 
get_identifiers_in_aexpr (Var identifier) = [identifier]
get_identifiers_in_aexpr (Neg aexpr) = get_identifiers_in_aexpr aexpr
get_identifiers_in_aexpr (ABinary _ aexpr1 aexpr2) = 
    (get_identifiers_in_aexpr aexpr1) ++ (get_identifiers_in_aexpr aexpr2)
get_identifiers_in_aexpr _ = []

get_identifiers_in_bexpr :: BExpr -> [String]
get_identifiers_in_bexpr (Not bexpr) = get_identifiers_in_bexpr bexpr 
get_identifiers_in_bexpr (BooleanBinary _ bexpr1 bexpr2) = 
    (get_identifiers_in_bexpr bexpr1) ++ (get_identifiers_in_bexpr bexpr2)
get_identifiers_in_bexpr (ArithmeticBinary _ aexpr1 aexpr2) = 
    (get_identifiers_in_aexpr aexpr1) ++ (get_identifiers_in_aexpr aexpr2)
get_identifiers_in_bexpr _ = [] 