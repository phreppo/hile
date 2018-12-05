module State
    (Entry,
     State(..),
     Partial(..),
     purify,
     state,
     bottom,
     empty_state,
     add_entry,
     partial_id
    )
where

data State = S [Entry]
           deriving (Show,Read)

type Entry = (String, Integer)

data Partial a = Undef
               | Defined a  
               deriving (Show,Read,Eq)

bottom :: State -> Partial State
bottom = \s -> Undef

purify :: Partial State -> State
purify (Defined s) = s

partial_id :: State -> Partial State
partial_id = Defined

instance Eq State where
    (S entries1) == (S entries2) =
        entries1 `is_contained` entries2 && entries2 `is_contained` entries1

state :: [Entry] -> State
state entries = S entries

is_contained :: [Entry] -> [Entry] -> Bool
is_contained [] _ = True
is_contained (first_entry:other_entries) entries2 =
    (entries2 `contains` first_entry) && (other_entries `is_contained` entries2)

contains :: [Entry] -> Entry -> Bool
contains []      entry = False
contains (first_entry:other_entries) entry =
    (first_entry == entry) || (other_entries `contains` entry)

empty_state :: State
empty_state = state []

add_entry :: State -> Entry -> State
add_entry (S list) entry = S ([entry] ++ list) 