module Lib
    (
        interpret,
        i
    ) 
where

import System.Random
import Control.Monad (replicateM)
    
import State
import WhileGrammar
import Semantics
import SugarRemover
import UpdateState
import Parser
import StateParser
import WhilePrograms

-- Interpretation process
--      . parse
--      . remove sugar
--      . initialize state
--      . interpret (plain) while program                

i :: (String,String) -> IO State
i (source_program, source_state) =
    interpret source_program (parse_state source_state)

interpret :: String -> State -> IO State
interpret source_program s = 
    interpret_parsed (parse source_program) s
        
interpret_parsed :: Stmt -> State -> IO State
interpret_parsed abstract_syntax_tree s =
    interpret_sugar_free (remove_sugar abstract_syntax_tree) s

interpret_sugar_free :: Stmt -> State -> IO State
interpret_sugar_free abstract_syntax_tree s = 
    do
        values <- get_random_integers (length identifiers)
        interpret_with_initialized_state 
            abstract_syntax_tree
            (update_entries (build_state identifiers values) s)
    where identifiers = get_identifiers_in_stmt abstract_syntax_tree

interpret_with_initialized_state :: Stmt -> State -> IO State 
interpret_with_initialized_state abstract_syntax_tree s =
    return $ (semantics abstract_syntax_tree) s

update_entries :: State -> State -> State          
-- takes the first state and overwrites values of the second on it
update_entries first_state (S []) = first_state
update_entries first_state (S (first_entry:other_entries)) =
    update_entries (update_entry first_entry first_state) (state other_entries)

build_state :: [String] -> [Integer] -> State
build_state identifiers values = state [entry | entry <- zip identifiers values]

get_random_integers :: Int -> IO [Integer]
get_random_integers n = replicateM n (get_random_integer)

get_random_integer :: IO Integer
-- Random generator: https://hackage.haskell.org/package/random-1.0.0.3/docs/src/System-Random.html
-- x = maxBound :: Int is used as upper bound
get_random_integer = randomIO

get_identifiers_in_stmt :: Stmt -> [String]
get_identifiers_in_stmt stmt =
    (remove_duplicates . get_identifiers_in_stmt_with_duplicate) stmt

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

remove_duplicates :: (Eq a) => [a] -> [a]
remove_duplicates list = rem_dups list []

rem_dups :: (Eq a) => [a] -> [a] -> [a]
rem_dups [] _ = []
rem_dups (x:xs) list2
    | (x `elem` list2) = rem_dups xs list2
    | otherwise = x : rem_dups xs (x:list2)
