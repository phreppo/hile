module WhilePrograms 
    (
        factorial,
        expon,
        fibonacci
    )
where

-- x!
factorial = "y:=1; while not (x = 1) do y := y*x; x := x-1"

--  x ^ y
expon = "accumulator := 1; for i:=1 to y do accumulator:=accumulator*x"

-- fib(x). p = fib(n-1), pp = fib(n-2)
fibonacci = "p := 1; pp := 0; for i:=2 to x do (fn := p+pp; pp := p; p := fn)"

-- https://coolconversion.com/math/factorial/_700_factorial%3F