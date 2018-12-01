module ParseWhile 
    ( parseString, 
    --   Stmt (
    --     Seq, 
    --     Assign, 
    --     If, 
    --     While, 
    --     Skip), 
    --   BExpr (..), 
    --   BBooleanBinOperator (..), 
    --   BArithmeticBinOperator (..), 
    --   AExpr (..), 
    --   AArithemticBinOperator (..), 
    )
where

import WhileGrammar
import System.IO
import Control.Monad
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Language
import qualified Text.ParserCombinators.Parsec.Token as Token

-------------------------------------------------------------------------------
--                                 LEXER
-------------------------------------------------------------------------------

languageDef =
    emptyDef {    Token.commentStart    = "/*"
                , Token.commentEnd      = "*/"
                , Token.commentLine     = "//"
                , Token.identStart      = letter
                , Token.identLetter     = alphaNum
                , Token.reservedNames   = 
                                        [ "if"
                                        , "then"
                                        , "else"
                                        , "while"
                                        , "do"
                                        , "skip"
                                        , "true"
                                        , "false"
                                        , "not"
                                        , "and"
                                        ]
                , Token.reservedOpNames = 
                                        [ "+", "-", "*", ":="
                                        , "<=", "=","and", "or", "not"
                                        ]
                }

lexer = Token.makeTokenParser languageDef

identifier = Token.identifier lexer 
reserved   = Token.reserved   lexer 
reservedOp = Token.reservedOp lexer 
parens     = Token.parens     lexer 
integer    = Token.integer    lexer 
semi       = Token.semi       lexer 
whiteSpace = Token.whiteSpace lexer 

-------------------------------------------------------------------------------
--                                 PARSER
-------------------------------------------------------------------------------

whileParser :: Parser Stmt
whileParser = whiteSpace >> statement

statement :: Parser Stmt
statement =  parens statement
            <|> sequenceOfStmt
    
sequenceOfStmt =
    do 
        list <- (sepBy1 statement' semi)
        return $ if length list == 1 then head list else Composition list

statement' :: Parser Stmt
statement' =  ifStmt
            <|> whileStmt
            <|> skipStmt
            <|> assignStmt

ifStmt :: Parser Stmt
ifStmt =
    do reserved "if"
       cond  <- bExpression
       reserved "then"
       stmt1 <- statement
       reserved "else"
       stmt2 <- statement
       return $ If cond stmt1 stmt2

whileStmt :: Parser Stmt
whileStmt =
    do reserved "while"
       cond <- bExpression
       reserved "do"
       stmt <- statement
       return $ While cond stmt

assignStmt :: Parser Stmt
assignStmt =
    do var  <- identifier
       reservedOp ":="
       expr <- aExpression
       return $ Assign var expr

skipStmt :: Parser Stmt
skipStmt = reserved "skip" >> return Skip

aExpression :: Parser AExpr
aExpression = buildExpressionParser aOperators aTerm
    
bExpression :: Parser BExpr
bExpression = buildExpressionParser bOperators bTerm

aOperators = [ [Prefix (reservedOp "-"   >> return (Neg             ))          ],
               [Infix  (reservedOp "*"   >> return (ABinary Multiply)) AssocLeft],
               [Infix  (reservedOp "+"   >> return (ABinary Add     )) AssocLeft,
                Infix  (reservedOp "-"   >> return (ABinary Subtract)) AssocLeft]
                ]
bOperators = [ [Prefix (reservedOp "not" >> return (Not                   ))          ],
               [Infix  (reservedOp "and" >> return (BooleanBinary And     )) AssocLeft]
                ]

aTerm =  parens aExpression
        <|> liftM Var identifier
        <|> liftM IntConst integer

bTerm =  parens bExpression
        <|> (reserved "true"  >> return (BoolConst True ))
        <|> (reserved "false" >> return (BoolConst False))
        <|> rExpression

rExpression =
        do a1 <- aExpression
           op <- relation
           a2 <- aExpression
           return $ ArithmeticBinary op a1 a2

relation =  (reservedOp "<=" >> return LessEq)
        <|> (reservedOp "=" >> return IsEqual)

-------------------------------------------------------------------------------
--                           PARSE INPUT FUNCTIONS
-------------------------------------------------------------------------------

parseStringWithList :: String -> Stmt
parseStringWithList str =
    case parse whileParser "" str of
    Left e  -> error $ show e
    Right r -> r

removeList :: Stmt -> Stmt
removeList (Composition seqList) 
    | length seqList == 1 = removeList $ head seqList
    | otherwise           = Seq (head seqList) (removeList $ Composition (tail seqList))
removeList (Assign identifier aexpr) = 
    Assign identifier aexpr
removeList (If bexpr stmt1 stmt2)    = 
    If bexpr (removeList stmt1) (removeList stmt2)
removeList (While bexpr body) = 
    While bexpr (removeList body)
removeList Skip =
    Skip

parseString :: String -> Stmt
parseString = (removeList . parseStringWithList)

-- parseFile :: String -> IO Stmt
-- parseFile file =
--     do program  <- readFile file
--         case parse whileParser "" program of
--             Left e  -> print e >> fail "parse error"
--             Right r -> return r