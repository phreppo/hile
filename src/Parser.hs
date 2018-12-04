{-# OPTIONS_GHC -w #-}
module Parser where
import Data.Char
import WhileGrammar

-- Op precedence: https://en.cppreference.com/w/cpp/language/operator_precedence
-- Happy precedence: https://www.haskell.org/happy/doc/html/sec-Precedences.html
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,118) ([9856,4,0,2,2464,1,0,4,0,1,0,0,5127,32770,2563,1,17280,60,32800,1,0,0,0,0,0,1536,40,1792,532,896,266,2048,768,32864,2,2464,1,0,5,0,0,0,1,3584,32768,2561,32768,1062,57344,17024,28672,8512,0,0,0,50360,3,6208,0,0,19712,8,192,5,32864,2,16432,1,40984,0,20492,0,10246,0,5123,32768,2561,0,896,0,448,0,224,0,112,0,56,0,0,0,8,0,4,0,32,0,0,0,0,0,32,0,0,128,1,11776,0,2125,0,8192,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","Stmt","AExpr","BExpr","int","var","bool","'skip'","'if'","'then'","'else'","'while'","'do'","'+'","'-'","'*'","'('","')'","':='","';'","'='","'not'","'and'","'or'","'<='","'>='","'<'","'>'","%eof"]
        bit_start = st * 31
        bit_end = (st + 1) * 31
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..30]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (8) = happyShift action_4
action_0 (10) = happyShift action_5
action_0 (11) = happyShift action_6
action_0 (14) = happyShift action_7
action_0 (19) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (19) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (8) = happyShift action_4
action_2 (10) = happyShift action_5
action_2 (11) = happyShift action_6
action_2 (14) = happyShift action_7
action_2 (19) = happyShift action_2
action_2 (4) = happyGoto action_19
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (22) = happyShift action_18
action_3 (31) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (21) = happyShift action_17
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_4

action_6 (7) = happyShift action_10
action_6 (8) = happyShift action_11
action_6 (9) = happyShift action_12
action_6 (17) = happyShift action_13
action_6 (19) = happyShift action_14
action_6 (24) = happyShift action_15
action_6 (5) = happyGoto action_8
action_6 (6) = happyGoto action_16
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (7) = happyShift action_10
action_7 (8) = happyShift action_11
action_7 (9) = happyShift action_12
action_7 (17) = happyShift action_13
action_7 (19) = happyShift action_14
action_7 (24) = happyShift action_15
action_7 (5) = happyGoto action_8
action_7 (6) = happyGoto action_9
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (16) = happyShift action_32
action_8 (17) = happyShift action_33
action_8 (18) = happyShift action_34
action_8 (23) = happyShift action_35
action_8 (27) = happyShift action_36
action_8 (28) = happyShift action_37
action_8 (29) = happyShift action_38
action_8 (30) = happyShift action_39
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (15) = happyShift action_31
action_9 (25) = happyShift action_25
action_9 (26) = happyShift action_26
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_7

action_11 _ = happyReduce_9

action_12 _ = happyReduce_15

action_13 (7) = happyShift action_10
action_13 (8) = happyShift action_11
action_13 (17) = happyShift action_13
action_13 (19) = happyShift action_23
action_13 (5) = happyGoto action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (7) = happyShift action_10
action_14 (8) = happyShift action_11
action_14 (9) = happyShift action_12
action_14 (17) = happyShift action_13
action_14 (19) = happyShift action_14
action_14 (24) = happyShift action_15
action_14 (5) = happyGoto action_28
action_14 (6) = happyGoto action_29
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (7) = happyShift action_10
action_15 (8) = happyShift action_11
action_15 (9) = happyShift action_12
action_15 (17) = happyShift action_13
action_15 (19) = happyShift action_14
action_15 (24) = happyShift action_15
action_15 (5) = happyGoto action_8
action_15 (6) = happyGoto action_27
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (12) = happyShift action_24
action_16 (25) = happyShift action_25
action_16 (26) = happyShift action_26
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (7) = happyShift action_10
action_17 (8) = happyShift action_11
action_17 (17) = happyShift action_13
action_17 (19) = happyShift action_23
action_17 (5) = happyGoto action_22
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (8) = happyShift action_4
action_18 (10) = happyShift action_5
action_18 (11) = happyShift action_6
action_18 (14) = happyShift action_7
action_18 (19) = happyShift action_2
action_18 (4) = happyGoto action_21
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (20) = happyShift action_20
action_19 (22) = happyShift action_18
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_1

action_21 (22) = happyShift action_18
action_21 _ = happyReduce_3

action_22 (16) = happyShift action_32
action_22 (17) = happyShift action_33
action_22 (18) = happyShift action_34
action_22 _ = happyReduce_2

action_23 (7) = happyShift action_10
action_23 (8) = happyShift action_11
action_23 (17) = happyShift action_13
action_23 (19) = happyShift action_23
action_23 (5) = happyGoto action_54
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (8) = happyShift action_4
action_24 (10) = happyShift action_5
action_24 (11) = happyShift action_6
action_24 (14) = happyShift action_7
action_24 (19) = happyShift action_2
action_24 (4) = happyGoto action_53
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (7) = happyShift action_10
action_25 (8) = happyShift action_11
action_25 (9) = happyShift action_12
action_25 (17) = happyShift action_13
action_25 (19) = happyShift action_14
action_25 (24) = happyShift action_15
action_25 (5) = happyGoto action_8
action_25 (6) = happyGoto action_52
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (7) = happyShift action_10
action_26 (8) = happyShift action_11
action_26 (9) = happyShift action_12
action_26 (17) = happyShift action_13
action_26 (19) = happyShift action_14
action_26 (24) = happyShift action_15
action_26 (5) = happyGoto action_8
action_26 (6) = happyGoto action_51
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_16

action_28 (16) = happyShift action_32
action_28 (17) = happyShift action_33
action_28 (18) = happyShift action_34
action_28 (20) = happyShift action_50
action_28 (23) = happyShift action_35
action_28 (27) = happyShift action_36
action_28 (28) = happyShift action_37
action_28 (29) = happyShift action_38
action_28 (30) = happyShift action_39
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (20) = happyShift action_49
action_29 (25) = happyShift action_25
action_29 (26) = happyShift action_26
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_10

action_31 (8) = happyShift action_4
action_31 (10) = happyShift action_5
action_31 (11) = happyShift action_6
action_31 (14) = happyShift action_7
action_31 (19) = happyShift action_2
action_31 (4) = happyGoto action_48
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (7) = happyShift action_10
action_32 (8) = happyShift action_11
action_32 (17) = happyShift action_13
action_32 (19) = happyShift action_23
action_32 (5) = happyGoto action_47
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (7) = happyShift action_10
action_33 (8) = happyShift action_11
action_33 (17) = happyShift action_13
action_33 (19) = happyShift action_23
action_33 (5) = happyGoto action_46
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (7) = happyShift action_10
action_34 (8) = happyShift action_11
action_34 (17) = happyShift action_13
action_34 (19) = happyShift action_23
action_34 (5) = happyGoto action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (7) = happyShift action_10
action_35 (8) = happyShift action_11
action_35 (17) = happyShift action_13
action_35 (19) = happyShift action_23
action_35 (5) = happyGoto action_44
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (7) = happyShift action_10
action_36 (8) = happyShift action_11
action_36 (17) = happyShift action_13
action_36 (19) = happyShift action_23
action_36 (5) = happyGoto action_43
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (7) = happyShift action_10
action_37 (8) = happyShift action_11
action_37 (17) = happyShift action_13
action_37 (19) = happyShift action_23
action_37 (5) = happyGoto action_42
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (7) = happyShift action_10
action_38 (8) = happyShift action_11
action_38 (17) = happyShift action_13
action_38 (19) = happyShift action_23
action_38 (5) = happyGoto action_41
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (7) = happyShift action_10
action_39 (8) = happyShift action_11
action_39 (17) = happyShift action_13
action_39 (19) = happyShift action_23
action_39 (5) = happyGoto action_40
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (16) = happyShift action_32
action_40 (17) = happyShift action_33
action_40 (18) = happyShift action_34
action_40 _ = happyReduce_23

action_41 (16) = happyShift action_32
action_41 (17) = happyShift action_33
action_41 (18) = happyShift action_34
action_41 _ = happyReduce_22

action_42 (16) = happyShift action_32
action_42 (17) = happyShift action_33
action_42 (18) = happyShift action_34
action_42 _ = happyReduce_21

action_43 (16) = happyShift action_32
action_43 (17) = happyShift action_33
action_43 (18) = happyShift action_34
action_43 _ = happyReduce_20

action_44 (16) = happyShift action_32
action_44 (17) = happyShift action_33
action_44 (18) = happyShift action_34
action_44 _ = happyReduce_19

action_45 _ = happyReduce_13

action_46 (18) = happyShift action_34
action_46 _ = happyReduce_12

action_47 (18) = happyShift action_34
action_47 _ = happyReduce_11

action_48 (22) = happyShift action_18
action_48 _ = happyReduce_6

action_49 _ = happyReduce_14

action_50 _ = happyReduce_8

action_51 (25) = happyShift action_25
action_51 _ = happyReduce_18

action_52 _ = happyReduce_17

action_53 (13) = happyShift action_55
action_53 (22) = happyShift action_18
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (16) = happyShift action_32
action_54 (17) = happyShift action_33
action_54 (18) = happyShift action_34
action_54 (20) = happyShift action_50
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (8) = happyShift action_4
action_55 (10) = happyShift action_5
action_55 (11) = happyShift action_6
action_55 (14) = happyShift action_7
action_55 (19) = happyShift action_2
action_55 (4) = happyGoto action_56
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (22) = happyShift action_18
action_56 _ = happyReduce_5

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn4
		 (Assign happy_var_1 happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Seq happy_var_1 happy_var_3
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  4 happyReduction_4
happyReduction_4 _
	 =  HappyAbsSyn4
		 (Skip
	)

happyReduce_5 = happyReduce 6 4 happyReduction_5
happyReduction_5 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 4 happyReduction_6
happyReduction_6 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (While happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn5
		 (IntConst happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  5 happyReduction_9
happyReduction_9 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn5
		 (Var happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Neg happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (ABinary Add happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  5 happyReduction_12
happyReduction_12 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (ABinary Subtract happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (ABinary Multiply happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  6 happyReduction_15
happyReduction_15 (HappyTerminal (TokenBoolConst happy_var_1))
	 =  HappyAbsSyn6
		 (BoolConst happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Not happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  6 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (BooleanBinary And happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  6 happyReduction_18
happyReduction_18 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (BooleanBinary Or happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  6 happyReduction_19
happyReduction_19 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (ArithmeticBinary IsEqual happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  6 happyReduction_20
happyReduction_20 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (ArithmeticBinary LessEq happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  6 happyReduction_21
happyReduction_21 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (ArithmeticBinary GreaterEq happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  6 happyReduction_22
happyReduction_22 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (ArithmeticBinary Less happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  6 happyReduction_23
happyReduction_23 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (ArithmeticBinary Greater happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 31 31 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenInt happy_dollar_dollar -> cont 7;
	TokenVar happy_dollar_dollar -> cont 8;
	TokenBoolConst happy_dollar_dollar -> cont 9;
	TokenSkip -> cont 10;
	TokenIf -> cont 11;
	TokenThen -> cont 12;
	TokenElse -> cont 13;
	TokenWhile -> cont 14;
	TokenDo -> cont 15;
	TokenPlus -> cont 16;
	TokenMinus -> cont 17;
	TokenTimes -> cont 18;
	TokenOB -> cont 19;
	TokenCB -> cont 20;
	TokenAssign -> cont 21;
	TokenSemi -> cont 22;
	TokenEq -> cont 23;
	TokenNot -> cont 24;
	TokenAnd -> cont 25;
	TokenOr -> cont 26;
	TokenLessEq -> cont 27;
	TokenGreaterEq -> cont 28;
	TokenLess -> cont 29;
	TokenGreater -> cont 30;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 31 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
calc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
    | TokenOr
    | TokenLessEq
    | TokenLess
    | TokenGreaterEq
    | TokenGreater
    | TokenWhile
    | TokenDo
    deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
        | isSpace c = lexer cs
        | isAlpha c = lexVar (c:cs)
        | isDigit c = lexNum (c:cs)
-- note that is important for pattern matching to have >= upper than >
lexer ('<':'=':cs) = TokenLessEq : lexer cs
lexer ('>':'=':cs) = TokenGreaterEq : lexer cs
lexer ('<':cs) = TokenLess : lexer cs
lexer ('>':cs) = TokenGreater : lexer cs
lexer (':':'=':cs) = TokenAssign : lexer cs
lexer ('+':cs) = TokenPlus : lexer cs
lexer ('-':cs) = TokenMinus : lexer cs
lexer ('*':cs) = TokenTimes : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs
lexer (';':cs) = TokenSemi : lexer cs
lexer ('=':cs) = TokenEq : lexer cs

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
        ("or",rest) -> TokenOr : lexer rest
        ("while",rest) -> TokenWhile : lexer rest
        ("do",rest) -> TokenDo : lexer rest
        (var,rest)   -> TokenVar var : lexer rest

-- main = getContents >>= print . calc . lexer

p string = (print . calc . lexer) string
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8814_0/ghc_2.h" #-}








































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
