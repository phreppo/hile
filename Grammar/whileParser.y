{
module Parser where
import Data.Char
import WhileGrammar

-- Op precedence: https://en.cppreference.com/w/cpp/language/operator_precedence
-- Happy precedence: https://www.haskell.org/happy/doc/html/sec-Precedences.html

}

%name calc
%tokentype { Token }
%error { parseError }
%nonassoc '>' '<'
%left '+' '-'
%left '*'
%left NEG

%left 'and'
%left 'not'

%left 'else' -- else is stronger than ;
%right ';'

%token 
      int             { TokenInt $$ }
      var             { TokenVar $$ }
      bool            { TokenBoolConst $$ }
      
      'skip'          { TokenSkip }

      'if'            { TokenIf }
      'then'          { TokenThen }
      'else'          { TokenElse }
      
      '+'             { TokenPlus }
      '-'             { TokenMinus }
      '*'             { TokenTimes }
      
      '('             { TokenOB }
      ')'             { TokenCB }
      
      ':='            { TokenAssign }
      ';'             { TokenSemi }
      
      '='             { TokenEq }
      'not'           { TokenNot }
      'and'           { TokenAnd }

%%

Stmt  : '(' Stmt ')'    { $2 }
      | var ':=' AExpr  { Assign $1 $3 }
      | Stmt ';' Stmt   { Seq $1 $3 }
      | 'skip'          { Skip }
      | 'if' BExpr 'then' Stmt 'else' Stmt { If $2 $4 $6 }

AExpr : int           { IntConst $1 }
      | '(' AExpr ')' { $2 }
      | var           { Var $1}
      | '-' AExpr %prec NEG     {Neg $2}
      | AExpr '+' AExpr         {ABinary Add $1 $3}
      | AExpr '-' AExpr         {ABinary Subtract $1 $3}
      | AExpr '*' AExpr         {ABinary Multiply $1 $3}

BExpr : '(' BExpr ')'           { $2 }
      | bool                    { BoolConst $1 }
      | 'not' BExpr             { Not $2 }
      | BExpr 'and' BExpr       { BooleanBinary And $1 $3 }


{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Token
    = TokenInt Integer
    | TokenBoolConst Bool
    | TokenVar String
    | TokenAssign
    | TokenPlus
    | TokenMinus
    | TokenTimes
    | TokenEq
    | TokenOB
    | TokenCB
    | TokenSemi
    | TokenSkip
    | TokenIf
    | TokenThen
    | TokenElse
    | TokenNot
    | TokenAnd
    deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
        | isSpace c = lexer cs
        | isAlpha c = lexVar (c:cs)
        | isDigit c = lexNum (c:cs)
lexer (':':'=':cs) = TokenAssign : lexer cs
lexer ('+':cs) = TokenPlus : lexer cs
lexer ('-':cs) = TokenMinus : lexer cs
lexer ('*':cs) = TokenTimes : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs
lexer (';':cs) = TokenSemi : lexer cs
-- lexer ('=':cs) = TokenEq : lexer cs

lexNum cs = TokenInt (read num) : lexer rest
        where (num,rest) = span isDigit cs

lexVar cs =
    case span isAlpha cs of
        ("if",rest) -> TokenIf : lexer rest
        ("then",rest) -> TokenThen : lexer rest
        ("else",rest) -> TokenElse : lexer rest
        ("skip",rest) -> TokenSkip : lexer rest
        ("true",rest) -> TokenBoolConst True : lexer rest
        ("false",rest) -> TokenBoolConst False : lexer rest
        ("not",rest) -> TokenNot : lexer rest
        ("and",rest) -> TokenAnd : lexer rest
        (var,rest)   -> TokenVar var : lexer rest

-- main = getContents >>= print . calc . lexer

p string = (print . calc . lexer) string

}