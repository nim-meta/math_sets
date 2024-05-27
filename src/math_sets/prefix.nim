
import ./types
export types
import std/sugar

func ran*[T](R: Relation[T]): Set[T] =
  ## range (值域)
  collect:
    for t in R: {t[1]}

func dom*[T](R: Relation[T]): Set[T] =
  ## domain (定义域)
  collect:
    for t in R: {t[0]}

func fld*[T](R: Relation[T]): Set[T] =
  ## field (域)
  ran R + dom R
