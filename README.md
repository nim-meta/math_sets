
# math-sets

## Desc
A sets library that provides notations of set theory (discrete math)

## Features

You can write set expression following (Assuming A, B are sets, R is a relation):

- `A ∩ B` `A ∪ B` `A ⊕ B`
- `A × B` 
- `ran A`, `dom A`, `fld A`
- `P(A)`
- `R[A]`
- `A/R`
- `card A`


## A compile-time interpreter

Assuming you're in this current directory and ` is a source file written in [math-like syntax](#interpreter-syntax) (see below),
you can run the interpreter with:

- Unix: `tools/interpreter.nims <setsStmtFile>` (maybe after `chmod +x tools/interpreter.nims`)
- Windows: `tools\nimr <setsStmtFile>`

> in fact you can call it a rewriter or preprocessor instead of a interpreter

[`examples/simple_ex.nim.txt`](./examples/simple_ex.nim.txt) is a simple example for `<setsStmtFile>`.

## interpreter-syntax
In short, 

- write as you do in mathematics: no need to write declaration via `let` or `var`
- don't forget to freely use Nim syntax: e.g. `echo A`
