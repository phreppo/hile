module State
    (Entry,
     State(..),
     bottom
    )
where


data State = Undef 
           | Def [Entry]
           deriving (Show,Read)

type Entry = (String, Integer)

instance Eq State where
    -- (Def []) == (Def []) = True
    (Def entries1) == (Def entries2) = 
        entries1 `is_contained` entries2 && entries2 `is_contained` entries1
    _ == _ = False

is_contained :: [Entry] -> [Entry] -> Bool
is_contained [] _ = True
is_contained (first_entry:other_entries) entries2 = 
    (entries2 `contains` first_entry) && (other_entries `is_contained` entries2)

contains :: [Entry] -> Entry -> Bool
contains []      entry = False 
contains (first_entry:other_entries) entry =
    (first_entry == entry) || (other_entries `contains` entry) 

bottom :: State
bottom = Undef