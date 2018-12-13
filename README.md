# hile

Interpreter written in Haskell for the While language described [here](http://www.daimi.au.dk/~bra8130/Wiley_book/wiley.pdf). It builds the semantic function of the code and then applies it to the given state. One may use the REPL function in the main or

```
stack ghci
```

and then the function `i` to interpret one program in one given state. For example:

```
i ("y:=1; while x != 1 do y:=y*x; x:=x-1","[x->7000]")
```

computes the factorial of 7000. This is the grammar of the language: 

![alt text](grammar.png "Logo Title Text 1")

The syntax is enriched enriched with some syntactic sugar, always removed before interpreting the program:

| Sugar        |
| ------------- |
| for       | 
| repeat      | 
| or | 
| < |
| > |
| >= |
| != |
| ^ |

To build the executable you need [happy](https://www.haskell.org/happy/) installed, one parser generator for Haskell. To build the executable run:

```
./generateGrammar
stack build
```

To run the REPL mode use:

```
./i
```