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

bottom :: State
bottom = Undef